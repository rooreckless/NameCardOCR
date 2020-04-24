# 1.AppName
NameCardOCR
# 2.イメージ
![NameCardOCR_Top](https://user-images.githubusercontent.com/60500414/80069906-1781a500-857d-11ea-8cbb-3f1432da7e62.png)
# 3.URL
https://www.app-namecardocr.work/
# 4.アプリ使用前に必要なこと
## 4-1.デバイスのカメラについて
このアプリケーションではブラウザで開いているデバイスのカメラを使用します。
アプリケーションがデバイスのカメラへのアクセスを求められた場合は「許可」を選択してください。

## 4-2.basic認証
id = admin <br>
pass = 1111

## 4-3.ユーザ登録
<img alt="NameCardOCR_ユーザ登録部" src="https://user-images.githubusercontent.com/60500414/80081927-916e5a00-858e-11ea-8ac2-81e5b60b3969.png" width="50%">
新規にユーザ登録をするか、googleアカウントをお持ちの方は「googleアカウントでログイン」してください。

# 5.このアプリの機能全体

## 5-1.ログイン後のトップページ上部 ユーザステータス表示
<img width="100%" alt="NameCardOCR_ユーザステータス表示部" src="https://user-images.githubusercontent.com/60500414/80083272-638a1500-8590-11ea-8bb3-755fc08372f1.png">

|表示        |説明                    |
|:---------|:---------------------|
|アプリロゴマーク|アプリのトップ画面に戻ります。 |
|ユーザ名     |現在のログインユーザ名。    |
|所属グループ名|ログインユーザが所属しているグループ。<br>グループに所属している状態なら、ユーザが新規登録する名刺は、同じグループ間であれば共有されます。|
|ログアウト     |このアプリからユーザがログアウトします。| 
|このアプリの使い方|このページを表示します。|


## 5-2.グループ機能
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

## 5-3.名刺の新規登録機能
<img width="70%" alt="名刺の新規登録機能ボタン" src="https://user-images.githubusercontent.com/60500414/80092169-4740a500-859d-11ea-8815-24453a36f6d1.png">

画面の指示に従い、デバイスのカメラを使用してアプリ内で、名刺を撮影します。<br>
撮影された画像から文字を読み取り、表示します。<br>
参加しているグループ　または　個人として「すでに登録した名刺と重複しているか」を確認したあと、
入力フォームがでますので適宜コピー&ペーストの後、登録してください。

## 5-4.名刺の詳細情報確認 と 名刺の人とのやりとり(エピソード)登録・確認機能
<img width="100%" alt="名刺の詳細情報確認機能画面" src="https://user-images.githubusercontent.com/60500414/80094823-e2d41480-85a1-11ea-8d9c-77629eb9a5b6.png">


### 5-4-1.名刺の内容
<img width="70%" alt="名刺の内容" src="https://user-images.githubusercontent.com/60500414/80146691-3029a380-85ed-11ea-8d4b-e2b89ba471f0.png">
名刺の内容確認が行えます。<br>
名刺の登録者であれば内容の編集・削除が可能です。<br>
また、名刺の登録内容に応じて右側の各種アイコンで下記の操作が行なえます。

|アイコン|表示           |
|:---------|:---------|
|虫めがねアイコン|会社名での名刺の再検索(ログインユーザが参加しているグループ内、および個人所有名刺内)
|地図アイコン|住所をgooglemapで表示|
|電話アイコン|(スマートフォンで利用の場合のみ利用可)デバイス標準の電話アプリが起動。表示されている電話番号に発信できます。|
|メールアイコン|デバイス標準のメールアプリが起動。表示されているメールアドレスへのメールを作成できます。|

### 5-4-2.名刺の方とのやりとり(エピソード)の新規作成
<img width="70%" alt="エピソードの新規作成" src="https://user-images.githubusercontent.com/60500414/80152903-80a5fe80-85f7-11ea-981d-bf36d23f3035.png">

画像の上部のフォームに入力の上、下のボタンを押してエピソードを新規作成します。

### 5-4-3. 名刺にかかわるエピソードの一覧表示
<img width="70%" alt="エピソードの一覧表示" src="https://user-images.githubusercontent.com/60500414/80154242-2a868a80-85fa-11ea-91a2-d15dc150f9b2.png">

この名刺の人について作成されたエピソードが表示されます。<br>
右側のアイコンはマウスを重ねると、そのエピソードを作成したユーザであれば、削除が行えます。<br>
詳細確認ボタンが表示され、エピソードの詳細画面が表示されます。
(エピソード詳細画面でも、そのエピソードを作成したユーザであればエピソードの編集、削除が可能です)

## 5-5.名刺の検索機能
<img width="100%" alt="名刺の検索機能ボタン" src="https://user-images.githubusercontent.com/60500414/80164487-1059a600-8614-11ea-96d1-30dd1ce803e1.png">
<a href="#user-content-5-3名刺の新規登録機能">Jump</a>
