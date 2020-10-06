require 'rails_helper'

RSpec.describe "新規投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @work = FactoryBot.build(:work)
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_work_path
      # フォームに情報を入力する
      select '手伝って欲しいです！', from: 'work[type_id]'
      fill_in 'work_name', with: @work.name
      fill_in 'work_place', with: @work.place
      select '部屋の掃除', from: 'work[genre_id]'
      select "#{Time.current.year + 1}", from: 'work[start_time(1i)]'
      select '1', from: 'work[start_time(2i)]'
      select '1', from: 'work[start_time(3i)]'
      select '10', from: 'work[start_time(4i)]'
      select '00', from: 'work[start_time(5i)]'
      select "#{Time.current.year + 1}", from: 'work[end_time(1i)]'
      select '1', from: 'work[end_time(2i)]'
      select '1', from: 'work[end_time(3i)]'
      select '16', from: 'work[end_time(4i)]'
      select '00', from: 'work[end_time(5i)]'
      fill_in 'work_description', with: @work.description
      # 投稿するとWorkモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(1)
      # トップページに移動する
      visit root_path
      # トップページには先ほど投稿した内容の投稿が存在することを確認する
      expect(page).to have_content(@work.name)
    end
  end
  
  context '投稿ができないとき' do
    it '誤った情報では投稿ができずに投稿ページに戻ってくる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_work_path
      # フォームに情報を入力する
      select '--選択してください--', from: 'work[type_id]'
      fill_in 'work_name', with: ""
      fill_in 'work_place', with: ""
      select '--選択してください--', from: 'work[genre_id]'
      select "#{Time.current.year}", from: 'work[start_time(1i)]'
      select '1', from: 'work[start_time(2i)]'
      select '1', from: 'work[start_time(3i)]'
      select '02', from: 'work[start_time(4i)]'
      select '00', from: 'work[start_time(5i)]'
      select "#{Time.current.year + 1}", from: 'work[end_time(1i)]'
      select '1', from: 'work[end_time(2i)]'
      select '1', from: 'work[end_time(3i)]'
      select '01', from: 'work[end_time(4i)]'
      select '00', from: 'work[end_time(5i)]'
      fill_in 'work_description', with: ""
      # 送信してもWorkモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(0)
      # 新規投稿ページへ戻されることを確認する
      expect(current_path).to eq "/works"
    end
    it 'ログインしていないと新規投稿ページに移動できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿をクリックするとログインページに移動する
      click_on '投稿する'
      expect(current_path).to eq "/users/sign_in"
    end
  end
end

RSpec.describe "投稿詳細", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @work = FactoryBot.create(:work)
  end

  it 'ログインしたユーザーは投稿詳細ページにコメントするボタンがある' do
    # ログインする
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 投稿があることを確認する
    expect(page).to have_content("#{@work.name}")
    # 投稿の詳細ページに移動する
    visit work_path(@work.id)
    # コメントするフォームがあることを確認する
    expect(page).to have_selector 'form'
  end
  it 'ログインしてないユーザーは投稿詳細ページにコメントするボタンがない' do
    # 投稿の詳細ページに移動する
    visit work_path(@work.id)
    # コメントするボタンがなくログインしてコメントするボタンがあることを確認する
    expect(page).to have_no_selector 'form'
  end
end

RSpec.describe "投稿編集", type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end

  context '投稿の編集ができるとき' do
    it '投稿したユーザーは編集ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @work1.user.email
      fill_in 'user_password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿1があることを確認する
      expect(page).to have_content("#{@work1.name}")
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがあることを確認する
      expect(page).to have_content('投稿を編集する')
      # 編集ページに移動する
      visit edit_work_path(@work1.id)
      # 投稿内容を編集する
      fill_in 'work_name', with: "#{@work1.name}+追加編集"
      fill_in 'work_description', with: "#{@work1.description}+追加編集"
      # 編集してもWorkモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(0)
      # 投稿の詳細ページに移動することを確認する
      expect(current_path).to eq work_path(@work1.id)
    end
  end
  
  context '投稿の編集ができないとき' do
    it 'ログインした投稿していないユーザーは編集ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @work2.user.email
      fill_in 'user_password', with: @work2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがないことを確認する
      expect(page).to have_no_content('投稿を編集する')
    end
    it 'ログインしていないユーザーは編集ができない' do
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがないことを確認する
      expect(page).to have_no_content('投稿を編集する')
    end
  end
end

RSpec.describe "投稿削除", type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end

  context '投稿が削除できるとき' do
    it '投稿したユーザーは投稿を削除できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @work1.user.email
      fill_in 'user_password', with: @work1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿1があることを確認する
      expect(page).to have_content("#{@work1.name}")
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがあることを確認する
      expect(page).to have_content('投稿を編集する')
      # 編集ページに移動する
      visit edit_work_path(@work1.id)
      # 投稿を削除したらWorkモデルのカウントが1下がりトップページに移動する事を確認する
      expect{
        page.accept_confirm do
          find_link('削除する').click
        end
        expect(current_path).to eq root_path
        }. to change { Work.count }.by(-1)
    end
  end

  context '投稿が削除できないとき' do
    it '投稿したユーザーでないユーザーは投稿を削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @work2.user.email
      fill_in 'user_password', with: @work2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがないことを確認する
      expect(page).to have_no_content('投稿を編集する')
    end
    it 'ログインしていないユーザーは投稿を削除できない' do
      # 投稿の詳細ページに移動する
      visit work_path(@work1.id)
      # 編集ページボタンがないことを確認する
      expect(page).to have_no_content('投稿を編集する')
    end
  end
end
