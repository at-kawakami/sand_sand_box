# ListBQDatasetBinding

## 説明

BQデータセットに紐づく特定のユーザをリスト化する

BigQueryのデータセット権限は、各データセットにユーザをバインドする形式であるため

CFはHTTPトリガーのものを使用する

## 呼び出し方

```sh
atsushi_kawakami@cloudshell:~ (hogeo-project)$ curl -m 310 -X POST https://asia-northeast1-hogeo-project.cloudfunctions.net/ListBQDatasetBinding \
> -H "Authorization: bearer $(gcloud auth print-identity-token)" \
> -H "Content-Type: application/json" \
> -d '{  "member": "atsushi.kawakami@hogefuga.jp" }'

```

