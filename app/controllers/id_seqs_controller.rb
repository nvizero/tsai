class IdSeqsController < ApplicationController

  layout "admin"
  #登入
  before_action :confirm_logged_in
  #取得一些基本資訊
  before_action :get_base_data

  before_action :set_id_seq, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  def comm
    return ['main1'=>'流水號', 'main2'=>'id_seqs','sub1'=>'首頁' , 'sub2'=>'流水號' ]
  end

  # GET /id_seqs
  # GET /id_seqs.json
  def index
    @title  = self.comm
    @table_title = "流水號列表"
    @id_seqs = IdSeq.order(sort_column + " " + sort_direction).all
  end

  # GET /id_seqs/1
  # GET /id_seqs/1.json
  def show
  end

  # GET /id_seqs/new
  def new
    @id_seq = IdSeq.new
  end

  # GET /id_seqs/1/edit
  def edit
    @title  = self.comm
  end

  # POST /id_seqs
  # POST /id_seqs.json
  def create
    @id_seq = IdSeq.new(id_seq_params)
    @id_seq.create_user_id = session[:user_id]
    respond_to do |format|
      if @id_seq.save
        format.html { redirect_to @id_seq, notice: 'Id seq was successfully created.' }
        format.json { render action: 'show', status: :created, location: @id_seq }
      else
        format.html { render action: 'new' }
        format.json { render json: @id_seq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /id_seqs/1
  # PATCH/PUT /id_seqs/1.json
  def update
    respond_to do |format|
      if @id_seq.update(id_seq_params)
        format.html { redirect_to @id_seq, notice: 'Id seq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @id_seq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DEadminE /id_seqs/1
  # DEadminE /id_seqs/1.json
  def destroy
    @id_seq.stop_user_id = session[:user_id]
    @id_seq.stoped_at = DateTime.now
    @id_seq.destroy
    respond_to do |format|
      format.html { redirect_to id_seqs_url }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      IdSeq.column_names.include?(params[:sort]) ? params[:sort] : "pre_id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_id_seq
      @id_seq = IdSeq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def id_seq_params
      params.require(:id_seq).permit(:pre_id, :seq)
    end
end
