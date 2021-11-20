# そもさんせっぱ
サイトurl : http://somosanseppa.com/

<img width="1579" alt="スクリーンショット 2021-11-09 18 18 44" src="https://user-images.githubusercontent.com/84437188/140896845-eab05fe8-9425-48fb-b087-85fc9a982865.png">

# サイト概要
「そもさんせっぱ」はユーザーにとって問いと学びをより身近にするための機会作りを行うアプリケーションです。
## 目的、ゴール
「ユーザーにとって問いと学びをより身近にするための機会作りをすること」が目的であり、「ユーザーがジャンル問わず質の高い問いと出会えること」、「問いを通じて、その内容についてより学べる機会があること」を実現することがゴールである。

## プロダクト開発・機能開発・改善の背景
<p>　人々にとっての学びが、何かを実現するため手段としての一面が強くなってしまい、純粋な興味に基づいた学びのきっかけに出会いづらくなっています。これは、学びの機会の損失であり、本アプリの解決したい課題です。
進路就職と強く結びつけられてしまった教育は、自主的に学ぶものではなく、目的のためせざるを得ない受動的な行為になりつつあると筆者は感じています。</p>
<p>　読書や学びの習慣の減り、好きな情報ばかり摂取できるようになった現代だからこそ、自分の視野の外に出会えるような学びにつながる「問い」と出会えるマッチングアプリを作ろうと思いました。</p>

# 設計
## 実装機能の大枠
- 馴染みのある、ハードルの低い4択クイズ形式</br>
 四択をメインとし、わからなくてもとりあえず答えるという行為のしやすい仕組み
- 正解不正解を意識させず、解説を優先するデザイン</br>
 目的は正解不正解に一喜一憂してもらうためではなく、新しいジャンルのことを知り、学びへの機会を提供すること。解説に参考サイトへのurlなどを積極的に記載するよう認証の際にお問い合わせを通じて働きかける。
- ユーザーが出会う問いを管理者が認証するシステム</br>
 より良い問いに出会うために、管理者が認証を行う。
## ワイヤーフレーム
https://xd.adobe.com/view/9a482c3d-81f3-4336-aacf-3b9554b3071c-cf1b/
## WBS
https://docs.google.com/spreadsheets/d/1ZhEZ1o4f_EDJXXwTNqysR6aPZduAxCQ0IMCYdsSpC08/edit#gid=2104957408
## 機能一覧
ver 1.0
| 機能                                                         | 一般ユーザー<br>利用可否 | 管理者<br>利用可否               | 
| :----------------------------------------------------------- | :----------------------: | :------------------------------: | 
| 今日の五問<br>(全ユーザーで共通の5つの問いを解く機能)        | ○                       | ○                               | 
| とりあえず1問<br>(あまり解いてない問いからランダムに1問出題) | ○                       | ○                               | 
| 問いの投稿                                                   | ○                       | ○                               | 
| 自身の投稿した問い編集                                       | ○                       | ○<br>(他ユーザーの<br>問いも可) | 
| 問い削除                                                     | ×                        | ×                                | 
| 問いの非公開                                                 | ×                        | ○                               | 
| 問い下書き                                                   | ×                        | ×                                | 
| 問いにいいね(Ajax)                                           | ○                       | ○                               | 
| 管理者とユーザーのチャット式お問い合わせ                     | ○                       | ○                               | 
| 公開された問い一覧の閲覧                                     | ○                       | ○                               | 
| 非公開された問い一覧の閲覧                                   | ×                        | ○                               | 
| 未承認、承認済ソート　問い一覧の閲覧                         | ○                       | ○                               | 
| 問いの認証ステータス変更                                     | ×                        | ○                               | 
| ユーザーの退会ステータス変更                                 | ×                        | ○                               | 
| ユーザーの管理者ステータス変更                               | ×                        | ○                               | 

ver 2.0　追加予定機能
| 機能                                                           | 一般ユーザー<br>利用可否 | 管理者<br>利用可否  | 
| -------------------------------------------------------------- | :----------------------: | :-----------------: | 
| 経験値獲得、レベル上昇機能                                     | ○                       | ○                  | 
| レベルに応じて作れるクイズの種類が増える<br>(画像、記述式など) | ○                       | ○                  | 
| →①クイズ本文に画像                                           | ○                       | ○                  | 
| →②記述式、<br>解説のgoogleAPIを用いた<br>ワードクラウド化    | ○                       | ○                  | 
| ユーザー一覧のレベルソート                                     | ○                       | ○                  | 
| お問い合わせ機能                                               | ○                       | ○                  | 
| 通知機能(認証、レベル、問い合わせ)                             | ○                       | ○                  | 
| 解かれた数にtoday_resultsも反映                                | ○                       | ○                  | 
| 解いた履歴にtoday_resultsも反映                                | ○                       | ○                  | 
| 問いへのいいね機能の実装。                                     | ○                       | ○                  | 
| 解説に外部リンクを載せられるように                                     | ○                       | ○                  | 
| 外部リンクへ遷移する際、アラートを出す。                                     | ○                       | ○                  | 
## ER図
ver 2.0
![Untitled Diagram drawio (6)](https://user-images.githubusercontent.com/84437188/142723434-91769ca6-6f6a-49d3-9501-45017bef745f.png)
(ver 1.0)
![Untitled Diagram drawio (1)](https://user-images.githubusercontent.com/84437188/140520645-847247ae-0f1b-4db3-a5bc-a9f8ec0630e1.png)

## 選定した解決手段について
### 機能面
- 選択肢が4択に限らず、n択(n:2~6)にできること。また、模範解答も1つ以上選べること</br>
4択の4にこだわる必要がななかったため、　ユーザーの投稿する問いの自由度を上げたかった。
- 今日の5問に選ばれたクイズは編集ができない件について<br>
urlの差し替えや、全くの別物にされることを防ぐため
- 認証済みのクイズを編集する場合、認証が外れることについて<br>
urlの差し替えや、全くの別物にされることを防ぐため
- 外部リンクに飛ぶ際にアラートがでることについて<br>
認証時に確認はするが、外部リンク先の差し替えなどには対応できないため、確認として出さざるを得ない。
### DB設計面
- 問いの削除機能ではなく、非公開ステータスで管理したこと</br>
ユーザーが解いている最中に削除されないようにするため。
- ユーザーの削除機能ではなく、退会ステータスで管理したこと</br>
ユーザーの作った問いが消えることを防ぐため
- resultとquizにポリモーフィック関連付が用いられていること。<br>
まず、今後の展望として、クイズの種類を増やすことが考えられている。そのため、複数モデルを同じクイズとして扱うためポリモーフィックで追加しやすいようにした。

## 選定しなかった解決手段について
### DB設計面<br>
- STI　と　複数種類のクイズの親モデル<br>
まず、今後の展望として、クイズの種類を増やすことが考えられている。その際、クラス継承を使いDRYにしようか考えたが、railsのテーブル継承はSTIのみと知り断念。<br>
「STi」,「ポリモーフィック関連付」,「親モデルQuizを設定する」の3択に絞った。<br>
STIを用いるかと考えたが、クイズの種類によってカラム構成が変わってくると考えられるため、STIは汎用性に乏しいと考え断念。<br>
親モデルを用いて実装することも考えたが、ResultやTodayQuizモデルとのアソシエーションがスッキリするが、viewの際、どのクイズモデルか判定しなければならないため、クイズのクエリが少々面倒くさくなってしまう。<br>
resultやtoay_quizをポリモーフィック関連付でした場合、メソッドなどの継承がないのは、moduleで解決できるので、ポリモーフィック関連付を採用した。

ver 1.0 のアソシエーション
![Untitled Diagram drawio (1)](https://user-images.githubusercontent.com/84437188/140520645-847247ae-0f1b-4db3-a5bc-a9f8ec0630e1.png)
ver 2.0 のアソシエーション
![Untitled Diagram drawio (3)](https://user-images.githubusercontent.com/84437188/140897447-fc00f7a3-d2a3-4fce-93cc-5e05239aedba.png)
### ライブラリ面
- ネストした選択肢の新規作成時formの増減や保存を、cocoonを用いず、javascriptで対応したこと<br>
"accepts_nested_attributes_for"をrails作者が消したいと考えていることから、使わない方法を考え、試してみたかった。




# 課題
## 現時点での実装における課題
 ただのクイズアプリとの差別化に「正解不正解の主張をおさえる」「解説に外部リンクをつけることを認証時、お問い合わせチャットを通じ勧める」「模範解答のない記述式の問いを採用する」などあるが、よりよい学びへのアプローチがあるように感じる。
- クイズを解いた後、学びに繋げる方法を模索しなければならない。<br>
　現時点では外部リンク対応と解説欄、みんなの回答のワードクラウド化しかない。<br>
 チャットやいいねなどの評価や、解説ページ、類似問題など、別の手段を模索する必要がある。<br>
- DB設計で今回STIを用いずポリモーフィックを採用したが、今のところ同じ構造となっているため、STIを採用した方が良かったかもしれない。<br>
 クイズの種類をもう少し考え、場合によってはSTIに刷新する
- 新規参加者がクイズを解く際、ログインしなければいけない。<br>
 今回はログイン機能にdeviseを用いたが、ログイン機能を自作し、<br>
「0.未ログイン」-> [1.名前だけのログイン]-> [2.メールアドレスとパスワードを用いたログイン]
と段階を設ける必要を感じる。
- GoogleNaturalLanguageAPIのEntity構文解析が、短文すぎるとEntityを抜き取ってくれないため、評価方式を考える必要がある。
　表示する度にリクエストを送っているので、ワードごとに評価し、その結果をDBに保存する仕組みを作るべきと考える。<br>
 また、正規化しないとJqCloudがうまく表示しないことにも注意
## テスト観点からの考察
単体テストだけでなく、ネストされた選択肢などについて結合テストが行われなければならない。
## 運用時の考慮事項
- 運用時の考慮事項
科学的に間違いのある問いを認証していた場合の対処。管理者がクイズを認証する際の確認フローを構築、共有すべき。
- 障害の発見と復旧手法
通知機能にアップデート機能も盛り込んでも良いかもしれない
## 
# 参考文献
https://spice-factory.co.jp/development/has-and-belongs-to-many-table/

# 次回アップデート予定内容
## ユーザー側
- 選択肢が画像のタイプの四択
- result画面に他プレイヤーの回答をグラフ表示
- GoogleNaturalLanguageAPIのEntity構文解析が、短文すぎるとEntityを抜き取ってくれないことへの対策
- ワードクラウドの重要度評価方式の変更と正規化
- クイズにタグ機能とタグソート機能を追加
- ツイッターで呟ける機能
etc.
## 管理者側
- 通知を送ることふができるフォームページの作成
etc.
# Docの編集の履歴
2021/11/09
2021/11/20

# 開発環境
- OS : Linux(CentOS)
- 言語 : HTML,CSS,Javascript,Ruby
- フレームワーク : Ruby on Rails
- JSライブラリ : jQuery
- IDE : Cloud9
# 本番環境
- EC2
