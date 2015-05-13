class StoreAreasController < ApplicationController
  before_action :set_store_area, only: [:show, :edit, :update, :destroy]

  # GET /store_areas
  # GET /store_areas.json
  def index
    @store_areas = StoreArea.all
  end

  # GET /store_areas/1
  # GET /store_areas/1.json
  def show
  end

  # GET /store_areas/new
  def new
    @store_area = StoreArea.new
  end

  # GET /store_areas/1/edit
  def edit
  end

  # POST /store_areas
  # POST /store_areas.json
  def create
    @store_area = StoreArea.new(store_area_params)

    respond_to do |format|
      if @store_area.save
        format.html { redirect_to @store_area, notice: 'Store area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store_area }
      else
        format.html { render action: 'new' }
        format.json { render json: @store_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_areas/1
  # PATCH/PUT /store_areas/1.json
  def update
    respond_to do |format|
      if @store_area.update(store_area_params)
        format.html { redirect_to @store_area, notice: 'Store area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_areas/1
  # DELETE /store_areas/1.json
  def destroy
    @store_area.destroy
    respond_to do |format|
      format.html { redirect_to store_areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_area
      @store_area = StoreArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_area_params
      params.require(:store_area).permit(:area_id, :area_name)
    end
end
