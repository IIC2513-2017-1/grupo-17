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
    new_params = gee_params
    new_params[:user_id] = 1
    @gee = Gee.new(new_params)
    @fields = []
    types = params[:field_types]
    names = params[:field_names]
    min_values = params[:field_min_values]
    max_values = params[:field_max_values]
    for i in 0..params[:field_types].length-1
      field = Field.create(
        gee: @gee.id,
        name: names[i],
        ttype: types[i],
        min_value: min_values[i],
        max_value: max_values[i])
      @fields.push(field)
    end
    @gee.fields = @fields
    respond_to do |format|
      if @gee.save
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
