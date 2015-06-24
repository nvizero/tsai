class UserBelongsController < ApplicationController
  before_action :set_user_belong, only: [:show, :edit, :update, :destroy]

  # GET /user_belongs
  # GET /user_belongs.json
  def index
    @user_belongs = UserBelong.all
  end

  # GET /user_belongs/1
  # GET /user_belongs/1.json
  def show
  end

  # GET /user_belongs/new
  def new
    @user_belong = UserBelong.new
  end

  # GET /user_belongs/1/edit
  def edit
  end

  # POST /user_belongs
  # POST /user_belongs.json
  def create
    @user_belong = UserBelong.new(user_belong_params)

    respond_to do |format|
      if @user_belong.save
        format.html { redirect_to @user_belong, notice: 'User belong was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_belong }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_belong.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_belongs/1
  # PATCH/PUT /user_belongs/1.json
  def update
    respond_to do |format|
      if @user_belong.update(user_belong_params)
        format.html { redirect_to @user_belong, notice: 'User belong was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_belong.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_belongs/1
  # DELETE /user_belongs/1.json
  def destroy
    @user_belong.destroy
    respond_to do |format|
      format.html { redirect_to user_belongs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_belong
      @user_belong = UserBelong.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_belong_params
      params.require(:user_belong).permit(:user_id, :belong_user_id)
    end
end
