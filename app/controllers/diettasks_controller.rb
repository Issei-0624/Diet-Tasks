class DiettasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
      @diettask = Diettask.new
  end

  def edit
  end

  def create
    @diettask = current_user.diettasks.build(diettask_params)
    if @diettask.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to user_url(id: current_user)
    else
      @diettasks = current_user.diettasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの作成に失敗しました。'
      render :new
    end
    
    # difference = (@diettask.limit_date - Date.today).to_i
    # unless difference >= 0
    #   flash[:error] = "期限日は作成日以降に設定してください！"
    #   root_path
    # end
  end
  
  def update
    if @diettask.update(diettask_params)
        flash[:success] = "タスクが正常に編集されました"
        redirect_to user_url(id: current_user)
    else
        flash.now[:danger] = "タスクが正常に編集されませんでした"
        render :edit
    end
  end

  def destroy
    @diettask = Diettask.find(params[:id])
    if @diettask.present?
    @diettask.destroy
    flash[:success] = 'タスク は正常に削除されました'
    redirect_back(fallback_location: user_url(id: current_user))
    end
  end
  
  def done
    @diettask = Diettask.find(params[:id])
    @diettask.update(status: "達成！")
    @diettask = Diettask.all.includes(:user)
    redirect_to user_url(id: current_user)
  end

  private

  def diettask_params
    params.require(:diettask).permit(:content, :status, :limit_date)
  end
  
  def correct_user
    @diettask = current_user.diettasks.find_by(id: params[:id])
    unless @diettask
      redirect_to user_url(id: current_user)
    end
  end
end
