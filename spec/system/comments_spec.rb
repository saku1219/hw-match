require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @work = FactoryBot.create(:work)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'user_email', with: @work.user.email
    fill_in 'user_password', with: @work.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 詳細ページに移動する
    visit work_path(@work)
    # フォームに情報を入力する
    fill_in 'comment_content', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がる事を確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされる
    expect(current_path).to eq work_path(@work)
    # 詳細ページ上に先ほどのコメント内容が含まれている事を確認する
    expect(page).to have_content @comment
  end
end

RSpec.describe 'コメント削除', type: :system do
  before do
    @comment = FactoryBot.create(:comment)
    @user = FactoryBot.create(:user)
  end

  context 'コメント削除できるとき' do
    it 'コメントしたユーザーは投稿したコメントを削除できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @comment.user.email
      fill_in 'user_password', with: @comment.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに移動する
      visit work_path(@comment.work_id)
      # 自分が投稿したコメントの横に削除するボタンがある事を確認する
      expect(page).to have_content('削除する')
      # コメントを削除するとレコードの数が1減る事を確認する
      expect{
        find_link('削除する').click
      }.to change { Comment.count }.by(-1)
    end
  end

  context 'コメント削除できないとき' do
    it 'コメントしていないユーザーはコメントを削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 詳細ページに移動する
      visit work_path(@comment.work_id)
      # 自分が投稿したコメントの横に削除するボタンがないことを確認する
      expect(page).to have_no_content('削除する')
    end
  end
end
