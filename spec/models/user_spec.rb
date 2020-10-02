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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it '重複したニックネームがあると登録できない'do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("ニックネームはすでに存在します")
      end
      it 'メールアドレスが空だと登録ができない'do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したメールアドレスがあると登録できない'do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'メールアドレスに「@」が含まれていないと登録ができない'do
        @user.email = 'test1234com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'パスワードが空だと登録ができない'do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'パスワードが7文字以下だと登録できない'do
        @user.password = 'Abcd123'
        @user.password_confirmation = 'Abcd123'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは8文字以上で入力してください")
      end
      it 'パスワードが半角英数字混合でないと登録できない'do
        @user.password = '12345678'
        @user.password_confirmation = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'パスワード(確認)が空だと登録できない'do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワード(確認)がパスワードと違うと登録できない'do
        @user.password_confirmation = 'ABC12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '電話番号が空だと登録できない'do
        @user.tel = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンがあると登録できない'do
        @user.tel = '090-1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は数値で入力してください")
      end
    end
  end
end
