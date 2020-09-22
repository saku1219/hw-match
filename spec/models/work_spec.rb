require 'rails_helper'

RSpec.describe Work, type: :model do
  before do
    @work = FactoryBot.build(:work)
  end

  describe 'ユーザー新規登録' do

    context '投稿できる' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@work).to be_valid
      end
    end

    context '投稿できない' do
      it '手伝って欲しい！ / 手伝えます！が選択されていないと投稿できない' do
        @work.type_id = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Type is invalid")
      end
      it '依頼名が空だと投稿できない' do
        @work.name = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Name can't be blank")
      end
      it '場所が空だと投稿できない' do
        @work.place = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Place can't be blank")
      end
      it 'ジャンルが選択されていないと投稿できない' do
        @work.genre_id = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Genre is invalid")
      end
      it '開始時間が現在より過去だと投稿できない' do
        @work.start_time = Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1)
        @work.valid?
        expect(@work.errors.full_messages).to include("Start time is valid")
      end
      it '終了時間が現在より過去だと投稿できない' do
        @work.end_time = Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1)
        @work.valid?
        expect(@work.errors.full_messages).to include("End time is valid")
      end
      it '終了時間が開始時間より過去だと投稿できない' do
        @work.end_time = Faker::Time.between(from: DateTime.now, to: DateTime.now + 1)
        @work.valid?
        expect(@work.errors.full_messages).to include("End time is valid")
      end
      it '詳細説明が空だと投稿できない' do
        @work.description = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Description can't be blank")
      end
    end
  end
end
