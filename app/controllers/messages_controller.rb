class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    work = Work.find(params[:work_id])
    chat = Chat.find(params[:chat_id])
    if message.save
      redirect_to "/works/#{work.id}/chats/#{chat.id}"
    else
      redirect_to "/works/#{work.id}/chats/#{chat.id}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id, chat_id: params[:chat_id])
  end
end
