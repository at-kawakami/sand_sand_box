# 概要

Pub/Sub上限のパブリッシュリクエスト1000メッセージを確認する用のソース

https://cloud.google.com/pubsub/quotas?hl=ja

>パブリッシュ リクエスト
>10 MB（合計サイズ）
>1,000 メッセージ

1publish内に>1000件のメッセージを詰めると、下記エラーが出る

```
google.api_core.exceptions.InvalidArgument: 400 The value for message_count is too large. You passed 1001 in the request, but the maximum value is 1000.
```
