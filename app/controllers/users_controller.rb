class UsersController < ApplicationController
  before_action :correct_user, only: [:show]

  def show
    @user = current_user.nickname
    @work = current_user.works.order('start_time ASC')
    @works = current_user.works.joins(chats: :user)
    @chat = Chat.where(work_id: @works).order('created_at DESC')
  end

  private

  def correct_user
    if !user_signed_in? || current_user.id.to_s != params[:id]
      redirect_to root_path
    end
  end
end
