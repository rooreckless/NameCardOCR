# AppName
NameCardOCR
# イメージ
![NameCardOCR_Top](https://user-images.githubusercontent.com/60500414/80069906-1781a500-857d-11ea-8cbb-3f1432da7e62.png)
# URL
https://www.app-namecardocr.work/
# アプリ使用前に必要なこと
## 1.デバイスのカメラについて
このアプリケーションではブラウザで開いているデバイスのカメラを使用します。
アプリケーションがデバイスのカメラへのアクセスを求められた場合は「許可」を選択してください。

## 2.basic認証
id = admin <br>
pass = 1111

## 3.ユーザ登録
<img alt="NameCardOCR_ユーザ登録部" src="https://user-images.githubusercontent.com/60500414/80081927-916e5a00-858e-11ea-8ac2-81e5b60b3969.png" width="50%">
新規にユーザ登録をするか、googleアカウントをお持ちの方は「googleアカウントでログイン」してください。

# このアプリの機能全体

## ログイン後のトップページ上部 ユーザステータス表示
<img width="100%" alt="NameCardOCR_ユーザステータス表示部" src="https://user-images.githubusercontent.com/60500414/80083272-638a1500-8590-11ea-8bb3-755fc08372f1.png">

|表示        |説明                    |
|:---------|:---------------------|
|アプリロゴマーク|アプリのトップ画面に戻ります。 |
|ユーザ名     |現在のログインユーザ名。    |
|所属グループ名|ログインユーザが所属しているグループ。<br>グループに所属している状態なら、ユーザが新規登録する名刺は、同じグループ間であれば共有されます。|
|ログアウト     |このアプリからユーザがログアウトします。| 
|このアプリの使い方|このページを表示します。|


## グループ機能
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

## 名刺の新規登録機能
<img width="70%" alt="名刺の新規登録機能ボタン" src="https://user-images.githubusercontent.com/60500414/80092169-4740a500-859d-11ea-8815-24453a36f6d1.png">

デバイスのカメラを使用してアプリ内で、名刺を撮影します。<br>
撮影された名刺から文字をよみとり、表示します。<br>
参加しているグループ　または　個人として「すでに登録した名刺と重複しているか」を確認したあと、
入力フォームがでますので適宜コピー&ペーストの後、登録してください。

## 名刺の詳細情報確認 と 名刺の人とのエピソード登録・確認機能
<img width="100%" alt="名刺の詳細情報確認機能画面" src="https://user-images.githubusercontent.com/60500414/80094823-e2d41480-85a1-11ea-8d9c-77629eb9a5b6.png">
|ログインユーザの状態|表示        |
|:---------|:---------|
|グループを未作成 & 未参加の場合|グループの新規作成画面 と グループ参加画面|
