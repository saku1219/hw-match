require 'rails_helper'

RSpec.describe 'チャット作成', type: :system do
  before do
    @comment = FactoryBot.create(:comment)
    @user = FactoryBot.create(:user)
  end
  
  context 'チャットルームが作成できるとき' do
    it 'ログインした依頼投稿ユーザーは他者のコメントからチャットルームを作成できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @comment.work.user.email
      fill_in 'user_password', with: @comment.work.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに移動する
      visit work_path(@comment.work_id)
      # 詳細ページ上に連絡するボタンが含まれている事を確認する
      expect(page).to have_selector 'input[value=連絡する]'
      # 連絡するボタンを押すと依頼投稿者とコメント投稿者のチャットルームが作成され、chatモデルのレコードが1増える事を確認する
      expect {
        find('input[value="連絡する"]').click
        }. to change { Chat.count }.by(1)
        # チャットルームに移動している事を確認する
        @chat = Chat.last
        expect(current_path).to eq "/works/#{@comment.work_id}/chats/#{@chat.id}"
    end
  end

  context 'チャットルームが作成できないとき' do
    it 'ログインした依頼投稿ユーザーではないユーザーは他者のコメントからチャットルームを作成できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに移動する
      visit work_path(@comment.work_id)
      # 詳細ページ上に連絡するボタンが含まれていない事を確認する
      expect(page).to have_no_selector 'input[value=連絡する]'
    end
  end
end

RSpec.describe 'チャット削除', type: :system do
  before do
    @comment = FactoryBot.create(:comment)
  end

  it 'チャットを削除する' do
    # ログインする
    visit new_user_session_path
    fill_in 'user_email', with: @comment.work.user.email
    fill_in 'user_password', with: @comment.work.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 詳細ページに移動する
    visit work_path(@comment.work_id)
    # チャットルームに移動する
    find('input[value="連絡する"]').click
    # 削除するボタンがある事を確認する
    expect(page).to have_content "チャットを\n削除する"
    # 削除するボタンを押すとチャットルームが削除され、chatモデルのレコードが1減る事を確認する
    expect {
      find_link("チャットを削除する").click
    }. to change { Chat.count }.by(-1)
    # トップページに移動する事を確認する
    expect(current_path).to eq root_path
  end
end
