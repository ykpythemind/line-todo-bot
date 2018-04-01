require 'line/bot'

class EntrypointController < ApplicationController
  def index
    reply = Reply.new
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)

    events.each do |event|
      # binding.pry
      type = event["source"]["type"]
      break unless type == "group"
      group_id = event["source"]["groupId"]
      break unless group_id == "C535046c0a45dd2afbdd42393e27795ab" || group_id == "C48c94a985f87a47e68bbc06af9b68e28" # me, nk # TODO: avoid hard coding
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          reply.token = event['replyToken']
          ReplyHandler.new(event.message['text'], reply).detect!
        end
      end
    end

    client.reply_message(reply.token, reply.content) if reply.need_to_reply?

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token  = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
