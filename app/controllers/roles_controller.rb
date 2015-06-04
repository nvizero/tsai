class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  # GET /roles
  # GET /roles.json
  def index
    # @users = User.order(:name).page params[:page]
    @roles = Role.page params[:page]
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role   = Role.new
    @aces   = Access.live
  end

  # GET /roles/1/edit
  def edit
    @aces   = Access.live
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    #權限
    @atext = ''
    params['point'].each do |po|
      @atext += po[0].to_s + ','
    end
    @role.text = @atext

    if @role.save

      flash[:notice] = "角色-新增成功!"
      redirect_to action: "index"
    else
      render action: 'new'
    end

    # respond_to do |format|
    #   if @role.save
    #     format.html { redirect_to @role, notice: 'Role was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @role }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @role.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update


    @atext = ''
    params['point'].each do |po|
      @atext += po[0].to_s + ','
    end

    @role.text = @atext

    if @role.update(role_params)
      flash[:notice] = "角色-更新成功!"
      redirect_to action: "index"
    else
      render action: 'edit'
    end




    # respond_to do |format|
    #   if @role.update(role_params)
    #     format.html { redirect_to @role, notice: 'Role was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @role.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.state = "N"
    @role.save
    respond_to do |format|
      format.html { redirect_to roles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    def set_title
      @title = ['main1'=>'⻆色管理', 'main2'=>'role','sub1'=>'首頁' , 'sub2'=>'⻆色管理']
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:title, :text)
    end
end
