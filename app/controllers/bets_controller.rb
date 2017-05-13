class BetsController < ApplicationController
  before_action :set_gee, :authorize

  # GET gees/:gee_id/bets
  def index
    if @gee.is_public
      @bets = Bet.where(gee: @gee)
    else
      redirect_to '/', error: 'You cannot see bets from non public Gees'
    end
  end

  # GET gees/:gee_id/bets/:id
  def show
    @bet = Bet.find(params[:id])
    if @bet.user != current_user
      redirect_to '/', error: 'You cannot see a bet if it is not yours'
    end
  end

  # GET gees/:gee_id/bets/new
  def new
    @bet = Bet.new
  end

  # POST gees/:gee_id/bets
  def create
    new_params = bet_params
    new_params[:user_id] = current_user[:id]
    @bet = Bet.new(new_params)
    @bet.gee = @gee

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
end
