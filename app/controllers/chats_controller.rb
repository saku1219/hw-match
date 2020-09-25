class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]
  before_action :move_to_index, only: [:show]

  def create
    @work = Work.find(params[:work_id])
    @chat = Chat.create(chat_params)
    redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
  end

  private

  def chat_params
    params.permit(:work_id, :user_id)
  end

  def set_chat
    @work = Work.find(params[:work_id])
    @chat = Chat.find(params[:id])
  end

  def move_to_index
    if !user_signed_in? || current_user.id != @work.user_id && current_user.id != @chat.user_id
      redirect_to root_path
    end
  end
end
