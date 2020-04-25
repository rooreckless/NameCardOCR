# 1.アプリ名
NameCardOCR
# 2.イメージ
![NameCardOCR_Top](https://user-images.githubusercontent.com/60500414/80069906-1781a500-857d-11ea-8cbb-3f1432da7e62.png)

# 3.URL
https://www.app-namecardocr.work/

# 4.概要
このアプリでは、「グループ間名刺共有と、名刺の人とのやりとり(エピソード)の共有」を実現します。<br>
名刺の登録や、一部の検索方法の際はデバイスのカメラを使用し、名刺の撮影をします。<br>
ただし、撮影された画像自体を画像ファイルとして保存せず、読み取った文字列を保存しています。

# 5.アプリ使用前に必要なこと
## 5-1.デバイスのカメラについて
このアプリケーションではブラウザで開いているデバイスのカメラを使用します。
アプリケーションがデバイスのカメラへのアクセスを求められた場合は「許可」を選択してください。

## 5-2.basic認証
id = admin <br>
pass = 1111

## 5-3.ユーザ登録
<img alt="NameCardOCR_ユーザ登録部" src="https://user-images.githubusercontent.com/60500414/80081927-916e5a00-858e-11ea-8ac2-81e5b60b3969.png" width="50%">
新規にユーザ登録をするか、googleアカウントをお持ちの方は「googleアカウントでログイン」してください。

# 6.使い方と全機能

+ <a href="#user-content-6-1ログイン後のトップページ上部-ユーザステータス表示">6-1.ログイン後のトップページ上部 ユーザステータス表示</a>
+ <a href="#user-content-6-2グループ機能">6-2.グループ機能</a>
+ <a href="#user-content-6-3名刺の新規登録機能">6-3.名刺の新規登録機能</a>
+ <a href="#user-content-6-4名刺の詳細情報確認-と-名刺の人とのやりとりエピソード登録確認機能">6-4.名刺の詳細情報確認 と 名刺の人とのやりとり(エピソード)登録・確認機能</a>
+ <a href="#user-content-6-5名刺の検索機能">6-5.名刺の検索機能</a>
+ <a href="#user-content-6-6名刺一覧表示">6-6.名刺一覧表示</a>

## 6-1.ログイン後のトップページ上部 ユーザステータス表示
<img width="100%" alt="NameCardOCR_ユーザステータス表示部" src="https://user-images.githubusercontent.com/60500414/80083272-638a1500-8590-11ea-8bb3-755fc08372f1.png">

|表示        |説明                    |
|:---------|:---------------------|
|アプリロゴマーク|アプリのトップ画面に戻ります。 |
|ユーザ名     |現在のログインユーザ名。    |
|所属グループ名|ログインユーザが所属しているグループ。<br>グループに所属している状態なら、ユーザが新規登録する名刺は、同じグループ間であれば共有されます。|
|ログアウト     |このアプリからユーザがログアウトします。| 
|このアプリの使い方|このページを表示します。|


## 6-2.グループ機能
<img width="70%" alt="グループ機能ボタン" src="https://user-images.githubusercontent.com/60500414/80086760-21af9d80-8595-11ea-9a6e-8a35b8768509.png">
グループの新規作成や、グループへの参加や退会、作成したグループ名やパスワードの変更ができます。<br>
ログインユーザの状態によって表示画面が異なります。

|ログインユーザの状態|表示        |
|:---------|:---------|
|グループを未作成 & 未参加の場合|グループの新規作成画面 と グループ参加画面|
+ グループを新規作成した場合、ユーザはグループのオーナーとしてそのグループに参加し、他のグループに参加できません
+ グループに参加するには、グループオーナーが設定したパスワードを入力する必要があります。
+ 1ユーザが参加できるグループは1つだけです。 
+ グループに参加している状態なら、同じグループに参加しているユーザが登録した名刺は、同じグループ間であれば共有されます。

|ログインユーザの状態|表示        |
|:---------|:---------|
|グループを作成したユーザの場合|グループ名とパスワードの編集画面　と グループ削除画面|
|グループを作成せず、なにかのグループに参加したユーザの場合|グループから退会画面|

## 6-3.名刺の新規登録機能
<img width="70%" alt="名刺の新規登録機能ボタン" src="https://user-images.githubusercontent.com/60500414/80092169-4740a500-859d-11ea-8815-24453a36f6d1.png">

画面の指示に従い、デバイスのカメラを使用してアプリ内で、名刺を撮影します。<br>
撮影された画像から文字を読み取り、表示します。<br>
参加しているグループ　または　個人として「すでに登録した名刺と重複しているか」を確認したあと、
入力フォームがでますので適宜コピー&ペーストの後、登録してください。

## 6-4.名刺の詳細情報確認 と 名刺の人とのやりとり(エピソード)登録・確認機能
<img width="100%" alt="名刺の詳細情報確認機能画面" src="https://user-images.githubusercontent.com/60500414/80094823-e2d41480-85a1-11ea-8d9c-77629eb9a5b6.png">


### 6-4-1.名刺の内容
<img width="70%" alt="名刺の内容" src="https://user-images.githubusercontent.com/60500414/80146691-3029a380-85ed-11ea-8d4b-e2b89ba471f0.png">
名刺の内容確認が行えます。<br>
名刺の登録者であれば内容の編集・削除が可能です。<br>
また、名刺の登録内容に応じて右側の各種アイコンで下記の操作が行なえます。

|アイコン|表示           |
|:---------|:---------|
|虫めがねアイコン|会社名での名刺の再検索(ログインユーザが参加しているグループ内、および個人所有名刺内)|
|地図アイコン|住所をgooglemapで表示|
|電話アイコン|(スマートフォンで利用の場合のみ利用可)デバイス標準の電話アプリが起動。表示されている電話番号に発信できます。|
|メールアイコン|デバイス標準のメールアプリが起動。表示されているメールアドレスへのメールを作成できます。|

### 6-4-2.名刺の方とのやりとり(エピソード)の新規作成
<img width="70%" alt="エピソードの新規作成" src="https://user-images.githubusercontent.com/60500414/80152903-80a5fe80-85f7-11ea-981d-bf36d23f3035.png">

画像の上部のフォームに入力の上、下のボタンを押してエピソードを新規作成します。

### 6-4-3. 名刺にかかわるエピソードの一覧表示
<img width="70%" alt="エピソードの一覧表示" src="https://user-images.githubusercontent.com/60500414/80154242-2a868a80-85fa-11ea-91a2-d15dc150f9b2.png">

この名刺の人について作成されたエピソードが表示されます。<br>
右側のアイコンはマウスを重ねると、そのエピソードを作成したユーザであれば、削除が行えます。<br>
詳細確認ボタンが表示され、エピソードの詳細画面が表示されます。
(エピソード詳細画面でも、そのエピソードを作成したユーザであればエピソードの編集、削除が可能です)

## 6-5.名刺の検索機能
<img width="100%" alt="名刺の検索機能ボタン" src="https://user-images.githubusercontent.com/60500414/80164487-1059a600-8614-11ea-96d1-30dd1ce803e1.png">

+ 「カメラを使用して検索」を選択した場合、<a href="#user-content-6-3名刺の新規登録機能">6-3名刺の新規登録機能</a>と同様にカメラで名刺を撮影して、登録済みの名刺を検索します。
+ 「文字入力で検索」を選択した場合、<a href="#user-content-6-4-1名刺の内容">6-4-1名刺の内容</a>で表示されている内容・項目で検索します。

## 6-6.名刺一覧表示
<img width="70%" alt="登録済み名刺一覧表示ボタン" src="https://user-images.githubusercontent.com/60500414/80169291-050c7780-8620-11ea-8569-b2e5f6eb3f7c.png">
登録済みの名刺を一覧表示します

# 7.このアプリの特徴

+ GoogleCloudPlatform の VisionAPIを使用した、OCRでの画像からの文字認識の使用
+ javascriptを使用してデバイスのカメラを使用し、撮影した名刺の画像を文字認識に利用
+ 前項について、撮影した画像自体を保存するのではなく、文字認識結果を保存して名刺を検索<br>このとき、認識した文字列の文字コードを利用して検索範囲を縮小し、レーベンシュタイン距離を用いた文字検索をして検索高速化を図る
+ googleのOAuth認証を使用したログイン
+ グループ作成時のパスワードの暗号化(bycryptGem使用)
+ JQueryを使用してなるべく一つのビューで名刺、エピソードのCRUDができるようにしたこと

# 8.開発環境
|項目|説明           |
|:---------|:---------|
|フレームワーク|ruby on rails|
|使用言語|Haml SCSS Ruby javascript jQuery|
|インフラ|AWS EC2(nginx,unicorn,mysql) ELB Route53|
|他|GitHub VisualStudioCode|

# 9.今後の課題

+ GoogleCloudPlatform の NaturalLanguageAPIを利用し、OCRでの読み取り文字から意図解釈し入力フォームへの自動入力
+ ページ内にチャットボットを搭載し、使用方法やこのアプリについての問い合わせを受け付ける体制の構築
+ ビデオチャット機能の構築

# 10.DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|unique: true, null: false|
|password|string|null: false|
|owned_group_id|integer||
|group_id|integer|foreign_key:true|
## Association
has_many :cards,dependent: :destroy
has_many :episodes,dependent: :destroy
belongs_to  :group, optional: true

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|company|string|null: false|
|department|string||
|address|string||
|tel|string||
|email|string||
|apiresulttext|text||
|apiresulthash|integer|
|user_id|integer|null:false, foreign_key: true|
|group_id|integer|foreign_key:true|
## Association
belongs_to :user
has_many :episodes, dependent: :destroy
belongs_to :group, optional: true

## episodesテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|when|string||
|where|string||
|card_id|integer|null:false, foreign_key: true|

## Association
belongs_to : card
belongs_to :user

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|password_digest|string|null: false, foreign_key: true|

## Association
has_secure_password
has_many :users
has_many :cards

# 11.作者
足立守<br>
メールアドレス t71.adachi.mamoru@gmail.com
