# HTTPTriggerSample

## 説明
HTTPエンドポイントからCFを呼ぶ場合に使用するサンプル

print-identity-token等による認証がないと、実行できない

### 呼び出し方サンプル

CFのUI「テスト中」タブの「CLI テストコマンド」と同じ

```sh
curl -m 310 -X POST https://asia-northeast1-${PROJECT_ID}.cloudfunctions.net/${CF_NAME} \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
 "name": "Hello World"
}'
```


## 構成
CF:$CF_NAME

## 呼び出し方

リクエストヘッダに、"Authorization: bearer $(gcloud auth print-identity-token)"を付与した、Curl
