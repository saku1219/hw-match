class ChatsController < ApplicationController

  def show
    @work = Work.find(params[:work_id])
    @chat = Chat.find(params[:id])
  end

  def create
    @work = Work.find(params[:work_id])
    @chat = Chat.create(chat_params)
    redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
  end

  private

  def chat_params
    params.permit(:work_id, :user_id)
  end
end
