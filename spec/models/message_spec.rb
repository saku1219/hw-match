require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do

    context '投稿できる' do
      it 'メッセージが入力されていれば投稿できる' do
        expect(@message).to be_valid
      end
    end

    context '投稿できない' do
      it 'メッセージが空だと投稿できない' do
        @message.content = ""
        @message.valid?
        expect(@message.errors.full_messages).to include("メッセージを入力してください")
      end
    end
  end
end
