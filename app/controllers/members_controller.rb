class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]



  before_action :set_title

  layout "admin"
  #取得一些基本資訊
  before_action :get_base_data
  #要登入
  before_action :confirm_logged_in



  helper_method :sort_column, :sort_direction


  # GET /members
  # GET /members.json
  def index
    # create_user_id = ''
    # notid=[1,2]
    # mems = Member.where("id not in(?)",notid)
    # mems.each do |mem|
    #   create_user_id = Random.rand(55)+2
    #   mem.create_user_id =create_user_id
    #   mem.delete
    # end

    # 666.times do |aa|
    #     Member.create(:name=>get_random_str(10) ,
    #                   :address=>get_random_str(10) ,
    #                   :tel=>aa,
    #                   :create_user_id =>aa )
    # end


    @users_a = self.user_to_ar
    @flag=params[:state]


    if @flag=='Y'
      @members = Member.vip_access(user_vip_access , session).live.order(sort_column + " " + sort_direction).page params[:page]
    elsif @flag=='N'
      @members = Member.vip_access(user_vip_access , session).stoped.order(sort_column + " " + sort_direction).page params[:page]
    else
      @flag='Y'
      @members = Member.vip_access(user_vip_access , session).live.order(sort_column + " " + sort_direction).page params[:page]
    end
    
    # @members = Member.vip_access(user_vip_access , session).live.page params[:page]
    # @members = Member.order(sort_column + " " + sort_direction).page params[:page]

  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
         @member.create_user_id = session[:user_id]
         @member.save
        format.html {
          redirect_to :controller =>'members' , :action=>'index'
          flash[:notice]  ='新增顧客成功！！'

          }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html {
          @member.modify_user_id = session[:user_id]
          @member.save

          redirect_to :controller =>'members' , :action=>'index'
          flash[:notice]  ='修改顧客資訊成功！！'

          }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.stop_user_id = session[:user_id]
    @member.stoped_at = DateTime.now
    @member.state = "N"
    @member.save


    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private



    def sort_column
      Member.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


    def set_title
      @title = ['main1'=>'顧客', 'main2'=>'members','sub1'=>'顧客' , 'sub2'=>'members']
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :tel, :address, :state)
    end
end
