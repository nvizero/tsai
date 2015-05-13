class IdSeqsController < ApplicationController
  
  layout "admin"

  before_action :set_id_seq, only: [:show, :edit, :update, :destroy]

  # GET /id_seqs
  # GET /id_seqs.json
  def index
    @id_seqs = IdSeq.all
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
  end

  # POST /id_seqs
  # POST /id_seqs.json
  def create
    @id_seq = IdSeq.new(id_seq_params)

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
    @id_seq.destroy
    respond_to do |format|
      format.html { redirect_to id_seqs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_id_seq
      @id_seq = IdSeq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def id_seq_params
      params.require(:id_seq).permit(:pre_id, :seq)
    end
end
