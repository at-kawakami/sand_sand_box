# GCSTriggerSample

## 説明
GCSトリガーで実行されるCFサンプル

バケットはあらかじめ作成しておくこと

※この設定だと、ファイル配置以外(ファイルの削除やアーカイブ等)のイベントでは実行されないので注意

## 構成
GCS > Eventarc(event trigger) > CF

gen2からEventarcが間に入るが、この構成であれば、特に気にする必要はなく、ファイルを置けばCFは実行される

## 呼び出し方

--trigger-bucket=$_TRIGGER_BUCKETで指定したバケットにファイルを配置する
