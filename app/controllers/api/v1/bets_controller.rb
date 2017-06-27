module Api::V1
  class BetsController < ApiController
    before_action :authenticate
    before_action :set_gee
    before_action :has_permission

    def index
      @bets = @gee.bets
    end

    def show
      @bet = @gee.bets.find_by(id: params[:id])
      if @bet.nil?
        render json: { error: "Bet with ID #{params[:id]} does not exists in this Gee" }
      end
    end

    def create
      fields = params[:fields]
      fields_values = params[:values]

      if fields.nil? or fields_values.nil?
        render json: { error: 'Fields and values must be provided' } and return
      elsif fields.length != fields_values.length
        render json: { error: 'Field array and value array must have the same length' } and return
      end

      @bet = Bet.new(params.permit(:quantity))
      @bet.gee = @gee
      @bet.user = @current_user

      if @current_user.money < params[:quantity].to_i
        render json: { error: 'You don\'t have enough money to make this bet' } and return
      end

      values = []
      @gee.fields.each do |field|
        i = fields.index(field.name)
        if i.nil?
          render json: { error: "Field #{field.name} is missing in the field array" } and return
        end
        value = Value.new(
            bet: @bet,
            field: field,
            value: fields_values[i].to_i
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
          @current_user.money -= @bet.quantity
          @current_user.save!
          success = true
        rescue
          raise ActiveRecord::Rollback
        end
      end

      if success
        render :show
      else
        render json: { error: @bet.errors }
      end

    end

    private
    def set_gee
      @gee = Gee.find_by(id: params[:gee_id])
      if @gee.nil?
        render json: { error: "Gee with ID #{params[:gee_id]} does not exists" }
      end
      @fields = @gee.fields
    end

    def has_permission
      unless @gee.is_public || @gee.users.include?(@current_user)
        render json: { error: 'This Gee is private and you don\'t have access to it' }
      end
    end

  end
end
