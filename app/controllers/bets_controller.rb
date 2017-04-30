class BetsController < ApplicationController
  before_action :set_gee

  # GET gees/:gee_id/bets
  def index
    @bets = Bet.where(gee: @gee)
  end

  # GET gees/:gee_id/bets/:id
  def show
    @bet = Bet.find(params[:id])
  end

  # GET gees/:gee_id/bets/new
  def new
    @bet = Bet.new
  end

  # POST gees/:gee_id/bets
  def create
    @bet = Bet.new(bet_params)
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
