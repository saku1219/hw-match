class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :destroy, :check]
  before_action :move_to_index, only: [:show]

  def create
    @work = Work.find(params[:work_id])
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
    else
      redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
    end
  end

  def show
    @message = Message.new
    @messages = @chat.messages.includes(:user)
  end

  def destroy
    if @chat.destroy
      redirect_to user_path
    else
      redirect_to user_path
    end
  end

    def check
      if @chat.check
        @chat.update(check: false)
        flash[:matcing_notice] = "マッチングを解除しました"
        redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
      else
        @chat.update(check: true)
        flash[:matcing_notice] = "マッチングが成立しました !"
        redirect_to "/works/#{@work.id}/chats/#{@chat.id}"
      end
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
