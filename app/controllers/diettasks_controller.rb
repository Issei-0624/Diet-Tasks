class DiettasksController < ApplicationController
  before_action :require_user_logged_in
  
  def new
      @diettask = Diettask.new
  end

  def edit
  end

  def create
    @diettask = current_user.diettasks.build(diettask_params)
    if @diettask.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to @user
    else
      @diettasks = current_user.diettasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの作成に失敗しました。'
      render :new
    end
  end
  
  def update
    if @task.update(task_params)
        flash[:success] = "タスクが正常に編集されました"
        redirect_to root_url
    else
        flash.now[:danger] = "タスクが正常に編集されませんでした"
        render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end

  private

  def diettask_params
    params.require(:diettask).permit(:content, :status, :limit_date)
  end
  
  def correct_user
    @diettask = current_user.diettasks.find_by(id: params[:id])
    unless @diettask
      redirect_to root_url
    end
  end
end
