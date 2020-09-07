class FavoritesController < ApplicationController
  def create
    diettask = Diettask.find(params[:diettask_id])
    current_user.like(diettask)
    flash[:success] = 'ユーザのタスクにいいねしました。'
    redirect_back(fallback_location: user_url(id: current_user))
  end

  def destroy
    diettask = Diettask.find(params[:diettask_id])
    current_user.unlike(diettask)
    flash[:success] = 'ユーザのタスクのいいねを解除しました。'
    redirect_back(fallback_location: user_url(id: current_user))
  end
end
