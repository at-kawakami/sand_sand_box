import sendgrid
import os
import sys

# Command Line
# python mail.py 1 `date +%s`

if __name__ == '__main__':
    args = sys.argv
    SENDGRID_API_KEY = 'SG.hogehoge'

    sg = sendgrid.SendGridAPIClient(api_key=SENDGRID_API_KEY)
    print(f'send {args[1]=} mail')
    send_count = int(args[1])
    send_at = int(args[2])


    # send multiple mails
    #i = 0
    #address = {}
    #to_row = []
    #while i < send_count:
    #    print(f'send {i} mails')
    #    # SendGrid loadtest endpoint
    #    address = f'loadtest+{i}@sink.sendgrid.net'
    #    to_row.append({'email': address})
    #    i = i + 1

    data = {
      "personalizations": [
        {
          # send multiple mails
          #"to": to_row,
          "to": [
            {"email": "hoge@gmail.com"}
            #{"email": "fuga@gmail.com"},
            #{"email": "piyo@gmail.com"}
          ],
          "subject": "メール送信テスト"
        }
      ],
      "from": {
        # SendGridでDomain Authentication認証したメアドを使用すること
        "email": "hoge@from_address.jp"
      },
      "content": [
        {
          "type": "text/plain",
          "value": "SendGridサービスを利用したメール送信テストです。"
          #"type": "text/html",
          #"value": "<a href=\"https://ifconfig.io/\">ifconfig.io</a>"
        }
      ],
      "send_at": send_at,
      "custom_args":
        {
          "arg_a": "hoge",
          "arg_id": 9999,
          "customer_id": "test-company",
        }
    }
    response = sg.client.mail.send.post(request_body=data)
    print(response.status_code)
    print(response.body)
    print(response.headers)
