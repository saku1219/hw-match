require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do

    context '投稿できる' do
      it '文字が入力されていれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '投稿できない' do
      it 'コメントが空だと投稿できない' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end
end
