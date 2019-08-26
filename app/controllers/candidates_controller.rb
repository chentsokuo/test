class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote] #還有 except 方法
  # 用 before_action 的話，在:show, :edit, :udate, :destroy就都可以不用寫 find_candidate



  def index
    @candidates = Candidate.all.order(vote: :desc)
  end

  def show
    # @candidate = Candidate.new(:id)
    # @candidate = Candidate.find_by(id: params[:id])
    # find_candidate
  end
  
  def edit
    # @candidate = Candidate.find_by(id: params[:id])
    # find_candidate
  end

  def new
    @candidate = Candidate.new
  end

  def update
    # @candidate = Candidate.find_by(id: params[:id])
    # find_candidate
    # clean_params = params.require(:candidate).permit(:name, :age, :policy, :party)

    if @candidate.update(candidate_params)
      # flash[:notice] = "更新成功!!"
      redirect_to '/candidates', notice: "更新成功！"
    else
      render :edit
    end
  end 
  
  def destroy
    # @candidate = Candidate.find_by(id: params[:id])
    # find_candidate
    @candidate.destroy
    # flash[:notice] = "資料刪除成功"
    # redirect_to root_path
    redirect_to root_path, notice: "資料刪除成功！"

  end

  def vote
    v = @candidate.vote || 0
    # @candidate.update(vote:v + 1)
    # VoteLog.new(candidate_id: @candidate.id, ip: remote_ip)
    VoteLog.create(candidate_id: @candidate.id, ip_address:request.remote_ip)
    redirect_to root_path, notice: "投票成功！"
  end

  def create

    #在終端機 打 rails console 可查看傳送到資料庫的資料 ex: Candidate.first
    #在終端機 打 rails c --sandbox 可以測試改變, 但是結束後會回復初始狀態

    # render html: "123"
    # render html: params
    # clean_params 叫做 strong parameter
    # clean_params = params.require(:candidate).permit(:name, :age, :policy, :party)
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      # flash[:notice] = "新增成功！"
      # redirect_to root_path
      
      redirect_to root_path, notice: "新增成功！"
    else
      # render html: 'UCCU'
      # redirect_to new_candidate_path

      render :new
    end

  end
  private
  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
  def candidate_params
    params.require(:candidate).permit(:name, :degree, :age, :policy, :party)
  end
end