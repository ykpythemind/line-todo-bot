# linebot

## development

- Channel 基本設定を行う https://developers.line.me/console/
  - App type : BOT
  - Plan     : For Developer

### .envファイルをプロジェクト直下に用意

```.env
LINE_CHANNEL_SECRET=dummy
LINE_CHANNEL_TOKEN=dummy
```

```
$ bundle install
$ npm i -g ngrok
$ ngrok http 3000
  * localhost:3000にフォワーディングされているアドレスをLINEのwebhookURLに登録
    e.g. https://0bdf966c.ngrok.io/webhook
$ bundle exec rails s
```

ngrokは起動毎にアドレスが変わるので注意

### 反応するグループIDを指定する

.envファイル内に以下を記述 (カンマ区切り)　グループIDはrails serverのログから判断できる

```
PERMITTED_GROUP_ID=hogehoge,piyopiyo
```


### deploy

* Docker
* https://github.com/ykpythemind/nginx-proxy Let's encrypt (webhookに登録するアドレスはSSL通信が必要)

```
$ docker-compose build
$ docker-compose up -d
更新
$ docker-compose build bot; docker-compose kill bot; docker-compose up -d
```
