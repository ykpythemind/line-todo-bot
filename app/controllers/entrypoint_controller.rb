require 'line/bot'

class EntrypointController < ApplicationController
  def index
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
      break unless permitted_group? event["source"]["groupId"]
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          handler = Handler.new(event.message['text'])
          handler.perform!
          handler.send_reply!(client, event['replyToken'])
        end
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token  = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  PERMITTED_GROUP_ID = ENV.fetch('PERMITTED_GROUP_ID', []).split(',')

  def permitted_group?(group_id)
    return true if PERMITTED_GROUP_ID.blank?
    PERMITTED_GROUP_ID.include? group_id
  end
end
