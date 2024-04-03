# HTTPWithLBSample

## 説明

デプロイしたCFのエンドポイントを、任意のFQDNから呼ぶ場合に使用するサンプル

LB経由でCFを呼ぶ場合に使用するサンプル

インターネット経由では呼べない

### 呼び出し方サンプル

e.g. https://FQDN/$CF_NAME

## 構成

DNS:FQDN > LB:FQDN > BackendService:$CF_NAME > CF:$CF_NAME
