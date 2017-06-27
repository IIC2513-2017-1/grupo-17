module Api::V1
  class GeesController < ApiController
    before_action :authenticate

    def index
      @gees = Gee.visible(@current_user).paginate(page: params[:page], per_page: 3).order('created_at DESC').includes(:bets, :user, :category)
    end

    def show
      @gee = Gee.find(params[:id])
    end

    def create
      new_params = gee_params
      new_params[:user_id] = current_user[:id]
      @gee = Gee.new(new_params)
      unless @gee.is_public
        @gee.users << current_user
      end
      @fields = []

      params[:fields].each do |field|
        if field[:type] == 'number'
          field = Field.new(
            gee: @gee.id,
            name: field[:name],
            ttype: field[:type].capitalize,
            min_value: field[:min_value].to_f,
            max_value: field[:max_value].to_f)
        elsif field[:type] == 'alternatives'
          field = Field.new(
            gee: @gee.id,
            name: field[:name],
            ttype: field[:type].capitalize,
            min_value: nil,
            max_value: nil)
          @alternatives = []
          field[:alternatives].each do |alternative|
            alternative = Alternative.new(
              field: field.id,
              value: alternative)
            @alternatives.push(alternative)
          end
          field.alternatives = @alternatives
        else
          raise "Type #{types[i]} does not exist"
        end
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
          format.json @gee
        else
          format.json {error: "There was an error"}
        end
      end
    end

    private

    def gee_params
      params.require(:gee).permit(:user_id, :name, :description, :category_id, :is_public, :expiration_date)
    end
  end
end
