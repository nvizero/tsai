class AccessesController < ApplicationController

  layout 'admin'

  before_action :set_access, only: [:show, :edit, :update, :destroy]

  before_action :set_title
  #要登入
  before_action :confirm_logged_in

  #取得一些基本資訊
  before_action :get_base_data


  # GET /accesses
  # GET /accesses.json
  def index
    # @users = User.order(:name).page params[:page]
    @accesses = Access.order(:id).page params[:page]
  end

  # GET /accesses/1
  # GET /accesses/1.json
  def show
  end

  # GET /accesses/new
  def new
    @access = Access.new
  end

  # GET /accesses/1/edit
  def edit
  end

  # POST /accesses
  # POST /accesses.json
  def create
    @access = Access.new(access_params)

    respond_to do |format|
      if @access.save
        format.html { redirect_to @access, notice: 'Access was successfully created.' }
        format.json { render action: 'show', status: :created, location: @access }
      else
        format.html { render action: 'new' }
        format.json { render json: @access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accesses/1
  # PATCH/PUT /accesses/1.json
  def update
    respond_to do |format|
      if @access.update(access_params)
        format.html { redirect_to @access, notice: 'Access was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accesses/1
  # DELETE /accesses/1.json
  def destroy
    @access.destroy
    respond_to do |format|
      format.html { redirect_to accesses_url }
      format.json { head :no_content }
    end
  end

  private

    def set_title
      @title  = ['main1'=>'權限', 'main2'=>'accesses','sub1'=>'權限' , 'sub2'=>'accesses' ]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_access
      @access = Access.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_params
      params.require(:access).permit(:title, :code)
    end
end
