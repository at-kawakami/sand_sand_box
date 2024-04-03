# PubSubTriggerSample

## 説明
Pub/SubのPublishトリガーで実行されるCFサンプル

この設定だと、Pub/Subサブスクリプションのフィルタ機能は使用出来ないので注意

フィルタを使用する場合は、HTTPトリガーのCFを作成する必要がある

## 構成
Pub/Sub > Eventarc(event trigger) > CF

gen2からEventarcが間に入るが、この構成であれば、特に気にする必要はない

## 呼び出し方

--trigger-topic=$_TRIGGER_TOPICで指定したPub/Sub トピックに、メッセージをpublishする
