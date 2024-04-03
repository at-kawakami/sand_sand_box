# PubSubTriggerWithFilterSample

## 説明
Pub/Sub Subscription filterを使用して、特定のattributesで実行されるCFサンプル

google_oauth2_cert.jsonは、https://www.googleapis.com/oauth2/v1/certsから最新の値を取得し、記載する

デプロイ完了後、Pub/Sub Subscriptionのpushエンドポイントに、CFのエンドポイントURLを指定する

e.g. push エンドポイント: https://asia-northeast1-${YOUR_PROJECT}.cloudfunctions.net/${YOUR_CF}

### verifyメソッドについて

Pub/Sub Subscription側で「認証を有効にする」を選択していれば、SA認証をPub/Sub>CF間で自動でやってくれるので、このメソッドはまるごと不要


## 構成
Pub/Sub > CF

## 呼び出し方

Pub/Sub Subscriptionにフィルタ(attributes.event = "hoge"とか)を登録し、pushエンドポイントをCFのURLにする

Pub/Sub トピックに、メッセージをpublishする

```sh
atsushi_kawakami@cloudshell:~ (hogeo-project)$ gcloud pubsub topics publish $TOPIC_NAME --attribute event="hoge"
messageIds:
- '9651390643689652'
```

## 認証　OAuthについて

[Google API](https://www.googleapis.com/oauth2/v1/certs) から公開鍵を取得し、google_oauth2_cert.jsonに記載しておいて、CF内部でトークン認証(jwt.decode部分)を行い、失敗したら、Google OAuthに直接トークン認証をリクエストする(id_token.verify_oauth2_token部分)

これは、google-authのソースに記載がある通り、大量アクセス時、トークン認証部分のHTTPリクエストがボトルネックになることを避けるための対応である

ソース: https://googleapis.dev/python/google-auth/latest/_modules/google/oauth2/id_token.html#verify_token

しかし、この運用を維持するには、定期的にgoogle_oauth2_cert.jsonを最新化する必要があるため、現状はこのロジックは実装だけしておき、

jwt.decodeでの認証エラーが出てもWARNを出力、Google OAuthに直接トークン認証をリクエストする(id_token.verify_oauth2_token部分)ことで、トークン認証はOKとする
