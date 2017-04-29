class GeesController < ApplicationController
  before_action :set_gee, only: [:show, :edit, :update, :destroy]

  # GET /gees
  # GET /gees.json
  def index
    @gees = Gee.all
  end

  # GET /gees/1
  # GET /gees/1.json
  def show
  end

  # GET /gees/new
  def new
    @gee = Gee.new
  end

  # GET /gees/1/edit
  def edit
  end

  # POST /gees
  # POST /gees.json
  def create
    Rails.logger.debug(params.inspect)
    new_params = gee_params
    new_params[:user_id] = 1
    @gee = Gee.new(new_params)
    @fields = []
    types = params[:field_types]
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
        raise "Type %{types[i]} does not exist"
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
        format.json { render :show, status: :created, location: @gee }
      else
        format.html { render :new }
        format.json { render json: @gee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gees/1
  # PATCH/PUT /gees/1.json
  def update
    respond_to do |format|
      if @gee.update(gee_params)
        format.html { redirect_to @gee, notice: 'Gee was successfully updated.' }
        format.json { render :show, status: :ok, location: @gee }
      else
        format.html { render :edit }
        format.json { render json: @gee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gees/1
  # DELETE /gees/1.json
  def destroy
    @gee.destroy
    respond_to do |format|
      format.html { redirect_to gees_url, notice: 'Gee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gee
      @gee = Gee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gee_params
      params.require(:gee).permit(:user_id, :name, :description, :category_id, :expiration_date)
    end
end
