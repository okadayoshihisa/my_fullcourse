## ■ サービス概要
漫画「トリコ」のように自分だけのフルコースを作成するサービスです。
オードブル(前菜)、スープ、魚料理、肉料理、メインディッシュ(主菜)、サラダ、デザート、ドリンクごとに食べ物を登録し、フルコースを共有できます。

## ■メインのターゲットユーザー
- トリコが好きな人
- グルメ好きな人

## ■ユーザーが抱える課題
トリコのキャラクターのように自分のフルコースを作り共有したいが、SNSの投稿でベタ打ちでは味気ない、画像を加工するのは手間

## ■解決方法
好きな食べ物を入力することで、漫画と同じ形で自分のフルコースを作成し、共有する。

## ■機能
- ユーザー登録、ログイン機能
- フルコースメニューの登録、編集
- フルコース一覧
- マップ上にフルコースメニューの表示
- フルコースを他ユーザーが評価できる

追加予定の機能
- フルコースメニュー一覧
- 検索機能
- 退会機能
- テスト作成
- OGP画像設定
- フルコースメニュー作成時に生成される画像のパターンを追加

## ■なぜこのサービスを作りたいのか？
私にとって漫画は人生の教科書であり、トリコは最も好きな作品の一つです。そのなかの美食屋たちはフルコースを完成させることを人生の目標としており、私も同じようにフルコースを完成させたいと思いました。また、それを共有し、他の人のフルコースを食べてみたいと思いました。

## ■使用技術
バックエンド
- Ruby 3.1.2
- Ruby on Rails 6.1.6

フロントエンド
- JavaScript
- Bootstrap

インフラ
- Heroku

使用API
- Maps JavaScript API（マップ検索に使用）
- Places API（店舗情報の取得に使用）
- Geocording API (緯度経度の取得に使用)

## ■スケジュール
~~README〜ER図作成：~ 6/7~~
~~メイン機能実装：6/8 ~ 6/28~~
~~β版をRUNTEQ内リリース（MVP）：6/28~~
β版をRUNTEQ内リリース（MVP）：9/15
本番リリース：9/30

## ■画面遷移図URL
https://www.figma.com/file/eHuy3gbolyUTZQK5u3gpKU/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0%3A1

## ■ER図
<img width="1135" alt="スクリーンショット 2022-09-22 1 54 24" src="https://user-images.githubusercontent.com/91833517/191565347-5099f054-a4dc-4900-98d8-15c3fcee7633.png">