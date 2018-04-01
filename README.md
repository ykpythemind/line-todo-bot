# linebot

## development

- Channel 基本設定を行う https://developers.line.me/console/
- .envファイルを直下に用意

```
$ npm i -g ngrok
$ ngrok http 3000
  * localhost:3000にフォワーディングされているアドレスをLINEのwebhookURLに登録
    e.g. https://0bdf966c.ngrok.io/webhook
$ bundle exec rails s
```

ngrokは起動毎にアドレスが変わるので注意
