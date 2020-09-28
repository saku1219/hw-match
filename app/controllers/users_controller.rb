class UsersController < ApplicationController

  def show
    @user = current_user.nickname
    @work = current_user.works
    @works = current_user.works.joins(chats: :user)
    @chat = Chat.where(work_id: @works)
  end
end
