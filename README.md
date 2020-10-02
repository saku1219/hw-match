# アプリケーション名
## かじマッチ
<br>
<br>
<br>

# 概要
- 部屋の掃除や洗濯などの家事を手伝って欲しい人と手伝ってくれる人のマッチング
- 時間があり手伝ってあげるよという人と家事を手伝ってくれる人をマッチング
<br>

以上の2点のマッチングをサポートします。
<br>
<br>
<br>

# 本番環境
https://hw-match.herokuapp.com/

## ログイン情報
### user1
- Email : test1@com
- password : test1234

### user2
- Email : test2@com
- password : test5678

### user3
- Email : test3@com
- password : test9090
<br>
<br>
<br>

# 制作背景（意図）
高齢化社会において、身寄りのない高齢者が一人で暮らしている世帯が増えてきています。<br>
子育て世代も時間に余裕がありません。<br>
高齢者には負担になる家事などを、時間がある人がお手伝いをする。<br>
時間のある高齢者には子守をしてもらうような相互関係が築いて欲しいという思いで制作しました。<br>
利用地域はご近所間での使用を想定して制作しました。
<br>
<br>
<br>

# DEMO
## トップページ
<img width="500" alt="スクリーンショット 2020-10-02 14 41 19" src="https://user-images.githubusercontent.com/69567957/94892061-b3b1bf80-04be-11eb-804f-9f69791d8050.png">
<br>

- 手伝って欲しい事の一覧と、手伝ってあげますよの一覧を同時に見れるようにしています。
- 家事の設定された終了時間を過ぎると表示されなくなります。
- マッチングが成立したものは表示されなくなります。
- ヘッダーのマイページとログアウトの表示は未ログイン時にはログインと新規登録という表示になります。
<br>
<br>

## 投稿ページ
<img width="500" alt="スクリーンショット 2020-10-02 15 04 33" src="https://user-images.githubusercontent.com/69567957/94892820-a695d000-04c0-11eb-9959-ec3beacae8f3.png">
<br>

- 開始時間が投稿時より過去の時間では投稿できません。
- 終了時間が投稿時より過去の時間では投稿できません。
- 終了時間が開始時間より過去の時間では投稿できません。
- 編集ページは投稿ページと同じ見た目です。
<br>
<br>

## 詳細ページ
<img width="500" alt="スクリーンショット 2020-10-02 14 42 22" src="https://user-images.githubusercontent.com/69567957/94892150-e3f95e00-04be-11eb-9afb-06d385e11ca0.png">
<br>

- 投稿の詳細をみることができます。
- コメントをすることができます。
- 投稿者はコメントをした人に「連絡する」ボタンを押すことができます。
- 「連絡する」ボタンを押すと投稿者とコメント投稿者の2人だけのチャットページに移動します。
- コメント投稿者は自分のコメントの右側に「削除する」ボタンが表示され、削除することができます。
- 未ログインユーザーはコメントすることができません。
<br>
<br>

## チャットページ
<img width="500" alt="スクリーンショット 2020-10-02 14 47 52" src="https://user-images.githubusercontent.com/69567957/94892192-03908680-04bf-11eb-8296-0ad28a8e944b.png">
<br>

- 2人だけのチャットページで詳細や公にしたくない話について話し合うことができます。
- マイページからもこのチャットに移動できます。
<br>
<br>

## マッチングボタンを押した時
<img width="500" alt="スクリーンショット 2020-10-02 14 48 21" src="https://user-images.githubusercontent.com/69567957/94892301-3fc3e700-04bf-11eb-9528-7475cce4a69c.png">
<br>

- 投稿者は「マッチング！」ボタンを押すことができます。押すとマッチング成立となります。
- マッチングが成立するとトップページには表示されなくなります。
<br>
<br>

## マイページ
<img width="500" alt="スクリーンショット 2020-10-02 14 48 41" src="https://user-images.githubusercontent.com/69567957/94892357-62560000-04bf-11eb-8939-207a55e53276.png">
<br>

- 自分が投稿中の物を一覧でみることができます。
- 自分が参加しているチャットの一覧をみることができます。
- チャット、投稿を削除をすることができます。
- 投稿を削除すると関連するチャットも削除されます。
<br>
<br>

## マイページ(マッチング成立した時)
<img width="500" alt="スクリーンショット 2020-10-02 15 40 13" src="https://user-images.githubusercontent.com/69567957/94895544-a0a2ed80-04c6-11eb-8baa-baa3470852ec.png">
<br>

- マッチングが成立したらマッチングと表示されます。
- 同じ投稿に対して複数の方とチャットをしていた場合、不成立となった方には「他の方とマッチング済み」と表示されます。
<br>
<br>

## 投稿削除時
<img width="300" alt="スクリーンショット 2020-10-02 15 56 34" src="https://user-images.githubusercontent.com/69567957/94896219-ee6c2580-04c7-11eb-82d7-bea5299bc09e.png">
<br>

- 投稿を削除する時はチャットも同時に削除されるため、アラートが表示されます。
<br>
<br>
<br>
<br>

# 工夫したポイント
コメント欄から直接メッセージルームを作成してページに移動できるようにしたことです。
すでにチャットルームが作成されている場合はページ移動をします。
<br>
<br>
<br>

# 使用技術(開発環境)
## バックエンド
- Ruby, Ruby on Rails
## フロントエンド
- HTML, CSS, Javascript
## データベース
- MySQL, SequelPro
## アプリケーションサーバ
- Heroku
## ソース管理
- GitHub, GitHubDesktop
## テスト
- RSpec
## エディタ
- VSCode
<br>
<br>
<br>

# 課題や今後実装したい機能
- 想定利用エリアがとても狭いです。現状は各地域毎にこのアプリケーションを導入する必要があり、とても非効率です。エリア毎に簡単に使用できるように拡張していく必要があります。
- ユーザー登録時にメール認証を導入したいです。
- チャットを非同期通信にしたいです。
- チャットに新規投稿があった時の通知機能を導入したいです。
<br>
<br>
<br>

# DB 設計
## usersテーブル

| Column    | Type    | Options                   |
| nickname  | string  | null: false, default: ""  |
| tel       | string  | null: false, default: ""  |
| email     | string  | null: false, default: ""  |
| pass      | string  | null: false, default: ""  |

### Association
has_many :works
has_many :comments
has_many :chats
has_many :messages

## worksテーブル

| Column      | Type        | Options                        |
| type_id     | integer     | null: false                    |
| name        | string      | null: false                    |
| genre_id    | integer     | null: false                    |
| place       | string      | null: false                    |
| start_time  | datetime    | null: false                    |
| end_time    | datetime    | null: false                    |
| description | text        | null: false                    |
| user        | references  | null: false, foreign_key: true |

### Association
belongs_to :user
has_many   :comments, dependent: :destroy
has_many   :chats, dependent: :destroy

## commentsテーブル

| Column    | Type       | Options                         |
| content   | text       | null: false                     |
| user      | references | null: false, foreign_key: true  |
| work      | references | null: false, foreign_key: true  |
### Association
belongs_to :user
belongs_to :work

## chatsテーブル
| Column  | Type        | Options            |
| work    | references  | foreign_key: true  |
| user    | references  | foreign_key: true  |
### Association
belongs_to :user
belongs_to :work
has_many :messages, dependent: :destroy

## messagesテーブル
| Column    | Type        | Options                         |
| content   | text        | null: false                     |
| user      | references  | null: false, foreign_key: true  |
| chat      | references  | null: false, foreign_key: true  |
### Association
belongs_to :user
belongs_to :chat
