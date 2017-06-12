class BetsController < ApplicationController
  before_action :set_gee
  before_action :require_login, only: [:new, :create]
  before_action :has_permission

  # GET gees/:gee_id/bets
  def index
    @bets = Bet.where(gee: @gee)
    @fields = Field.where(gee: @gee)
    query = 'SELECT field_id, value, sum(bets.quantity), count(*) FROM bets, values
      WHERE bets.id=values.bet_id AND bets.gee_id=3 GROUP BY field_id, value'
    @statistics = ActiveRecord::Base.connection.execute(query)
  end

  # GET gees/:gee_id/bets/:id
  def show
    @bet = Bet.find(params[:id])
  end

  # GET gees/:gee_id/bets/new
  def new
    @bet = Bet.new
    if @gee.expiration_date > Time.current
      render layout: false
    else
      render '<h2>This gee has reached its expiration time, so no more bets can be made.</h2>'
    end
  end

  # POST gees/:gee_id/bets
  def create
    new_params = bet_params
    new_params[:user_id] = current_user[:id]

    @bet = Bet.new(new_params)
    @bet.gee = @gee

    if current_user.money < new_params[:quantity].to_i
      flash.now[:alert] = 'You don\'t have enough money.'
      render :new and return
    end

    values = []
    @gee.fields.each do |field|
      value = Value.new(
        bet: @bet,
        field: field,
        value: params["field_#{field.id}"]
      )
      values.push(value)
    end

    success = false
    Bet.transaction do
      begin
        values.each do |value|
          value.save!
        end
        @bet.save!
        current_user.money -= @bet.quantity
        current_user.save!
        success = true
      rescue
        raise ActiveRecord::Rollback
      end
    end

    if success
      redirect_to gee_bet_path(@gee, @bet), notice: 'Bet was successfully created.'
    else
      render :new
    end
  end

  private
    def set_gee
      @gee = Gee.find(params[:gee_id])
    end

  # Never trust parameters from the scary internet, only allow the white list through.
    def bet_params
      params.require(:bet).permit(:user_id, :quantity)
    end

    def has_permission
      unless @gee.is_public || @gee.users.include?(current_user)
        redirect_to root_path, notice: 'You have no permission.'
      end
    end
end
