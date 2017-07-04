class GeesController < ApplicationController
  before_action :set_gee, only: [:show, :close, :update, :destroy, :show_invite, :invite, :delete_member]
  before_action :require_login, only: [:new, :create, :show_invite, :invite, :delete_member]
  before_action :require_admin, only: [:close, :update]
  before_action :has_permission, only: [:show, :show_invite, :invite, :delete_member]

  def get_gees(page)
    respond_to do |format|
      format.json {  }
    end
  end

  # GET /gees
  def index
    @gees = Gee.visible(current_user).paginate(page: params[:page], per_page: 3).order('created_at DESC').includes(:bets, :user, :category)
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @gees.to_csv }
      format.xls { send_data @gees.to_csv(col_sep: "\t") }
    end
  end

  # GET /gees/1
  def show
  end

  # GET /gees/new
  def new
    @gee = Gee.new
  end

  # GET /gees/1/close
  def close
  end

  # PATCH /gees/1
  def update
    @gee.fields.each do |field|
      field.update!(correct_value: params["field_#{field.id}"])
    end
    @gee.state = 'closed'
    @gee.save

    money_well = @gee.money_well
    winner_bets = @gee.winner_bets
    factor = winner_bets.map { |bet| bet.quantity }.sum.to_f

    @gee.bets.includes(:user).each do |bet|
      if winner_bets.include? bet
        earnings = (bet.quantity / factor) * money_well
        earnings = earnings.to_i
        user = bet.user
        user.money += earnings
        user.save
        #UserMailer.gee_winner(user, @gee, earnings).deliver_later
      else
        #UserMailer.gee_looser(bet.user, @gee).deliver_later
      end
    end
    redirect_to @gee, notice: 'The gee has been closed and the money has been distrubuted among bettors'
  end

  # GET /gees/1/invite
  def show_invite
    @friends = current_user.friends
  end

  # POST /gees/1/invite/:user_id
  def invite
    user = User.find(params[:user_id])
    @gee.users << user
    respond_to do |format|
      if @gee.save!
        user.notifications.create(
          title: 'Gee invitation',
          description: "#{current_user.username} has invited you to #{@gee.name}",
          url: "/gees/#{@gee.id}")
        format.html { redirect_to @gee, notice: "#{user.username} was successfully invited." }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /gees/1/invite/:user_id
  def delete_member
    user = User.find(params[:user_id])
    if current_user == @gee.user || current_user == user
      @gee.users.delete(user)
      respond_to do |format|
        if @gee.save!
          if current_user == @gee.user
            format.html { redirect_to @gee, notice: "#{user.username} was successfully removed." }
          else
            format.html { redirect_to user_path(current_user), notice: "You left #{@gee.name}." }
          end
        else
          format.html { render :new }
        end
      end
    else
      format.html { redirect_to @gee, notice: "You don't have the permission to do that."}
    end
  end

  # POST /gees
  def create
    new_params = gee_params
    new_params[:user_id] = current_user[:id]
    @gee = Gee.new(new_params)
    unless @gee.is_public
      @gee.users << current_user
    end
    @fields = []
    types = params[:field_types]
    types = [] if types.nil?
    names = params[:field_names]
    min_values = params[:field_min_values]
    max_values = params[:field_max_values]
    alternative_numbers = params[:alternative_numbers]
    alternative_names = params[:alternative_names]
    cur_alternative_number = 0
    for i in 0..types.length-1
      if types[i] == 'Number'
        field = Field.new(
          gee: @gee.id,
          name: names[i],
          ttype: types[i],
          min_value: min_values[i].to_f,
          max_value: max_values[i].to_f)
      elsif types[i] == 'Alternatives'
        field = Field.new(
          gee: @gee.id,
          name: names[i],
          ttype: types[i],
          min_value: nil,
          max_value: nil)
        @alternatives = []
        for j in cur_alternative_number..cur_alternative_number + alternative_numbers[i].to_i - 1
          alternative = Alternative.new(
            field: field.id,
            value: alternative_names[j])
          @alternatives.push(alternative)
        end
        field.alternatives = @alternatives
      else
        raise "Type #{types[i]} does not exist"
      end
      cur_alternative_number += alternative_numbers[i].to_i
      @fields.push(field)
    end
    @gee.fields = @fields
    respond_to do |format|
      success = false
      Gee.transaction do
        begin
          for field in @gee.fields
            for alternative in field.alternatives
              alternative.save!
            end
            field.save!
          end
          @gee.save!

          success = true
        rescue
          raise ActiveRecord::Rollback
        end
      end
      if success
        format.html { redirect_to @gee, notice: 'Gee was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gee
      @gee = Gee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gee_params
      params.require(:gee).permit(:user_id, :name, :description, :category_id, :is_public, :expiration_date)
    end

    def has_permission
      unless @gee.is_public || @gee.users.include?(current_user)
        redirect_to root_path, notice: 'You have no permission.'
      end
    end
end
