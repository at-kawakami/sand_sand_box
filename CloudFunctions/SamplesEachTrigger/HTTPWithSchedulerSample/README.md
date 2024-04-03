# HTTPWithScheduler 

## 説明
任意のSchedulerからCFを呼ぶ場合に使用するサンプル

CFはHTTPトリガーのものを使用する

schedulerは手動で作成すること

※gcloudコマンドではcreateを複数回打てない(already existsエラーになる)ため、CDに適さないため

## 構成
Scheduler:$CF_NAME > CF:$CF_NAME

## 呼び出し方

e.g. Schedulerから定期実行、もしくは強制実行
