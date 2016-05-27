class ContactusController < ApplicationController

  before_action :set_contactu, only: [:show, :edit, :update, :destroy]

  layout 'admin'

  before_action :set_title
  #要登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data
  helper_method :sort_column, :sort_direction
  # GET /contactus
  # GET /contactus.json
  def index
    @contactus = Contactu.order(sort_column + " " + sort_direction).page params[:page]
  end


  # GET /contactus/1
  # GET /contactus/1.json
  def show
  end

  # GET /contactus/new
  def new
    @contactu = Contactu.new
  end

  # GET /contactus/1/edit
  def edit
  end

  # POST /contactus
  # POST /contactus.json
  def create
    @contactu = Contactu.new(contactu_params)
    respond_to do |format|
      if @contactu.save
        format.html {

          # @contactu.title
          # @contactu.content

          _data = @contactu
          UserMailer.contact_us(_data).deliver
          UserMailer.system_repeat(_data).deliver
          # redirect_to @contactu, notice: 'Contactu was successfully created.'

          flash[:notice] = '寄送成功!!!!!'
          redirect_to :controller =>'msgs'  , :action =>'show' , :id=>1


        }
        format.json { render action: 'show', status: :created, location: @contactu }
      else
        format.html { render action: 'new' }
        format.json { render json: @contactu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contactus/1
  # PATCH/PUT /contactus/1.json
  def update
    respond_to do |format|
      if @contactu.update(contactu_params)
        format.html { redirect_to @contactu, notice: 'Contactu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contactu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactus/1
  # DELETE /contactus/1.json
  def destroy
    @contactu.destroy
    respond_to do |format|
      format.html { redirect_to contactus_url }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      Contactu.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_title
      @title  = ['main1'=>'聯絡我們', 'main2'=>'contact us','sub1'=>'聯絡我們' , 'sub2'=>'contact us' ]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_contactu
      @contactu = Contactu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contactu_params
      params.require(:contactu).permit(:title, :content,:email)
    end
end
