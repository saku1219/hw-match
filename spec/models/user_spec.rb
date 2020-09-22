require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '登録できる' do
      it 'すべての値が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できない' do
      it 'ニックネームが空だと登録ができない'do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it '重複したニックネームがあると登録できない'do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Nickname has already been taken")
      end
      it 'メールアドレスが空だと登録ができない'do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスがあると登録できない'do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに「@」が含まれていないと登録ができない'do
        @user.email = 'test1234com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空だと登録ができない'do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが7文字以下だと登録できない'do
        @user.password = 'Abcd123'
        @user.password_confirmation = 'Abcd123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
      end
      it 'パスワードが半角英数字混合でないと登録できない'do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワード(確認)が空だと登録できない'do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワード(確認)がパスワードと違うと登録できない'do
        @user.password_confirmation = 'ABC12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '電話番号が空だと登録できない'do
        @user.tel = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号にハイフンがあると登録できない'do
        @user.tel = '090-1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Tel is not a number")
      end
    end
  end
end
