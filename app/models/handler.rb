class Handler
  attr_reader :reply
  attr_accessor :message

  def initialize(message)
    @message = message
    @reply = Reply.new
  end

  def send_reply!(client, token)
    client.reply_message(token, reply.content) if reply.need_to_reply?
  end

  def detect!
    Message.detect!(message) do |type|
      case type
      when :add
        add_task
      when :done
        done_task
      when :all
        show_all_tasks
      when :usage
        show_usage
      when :version
        show_version
      end
    end
  end

  private

  def done_task
    raw = message.strip
    ids = if raw.include?(",")
            raw.split(',')
          else
            [raw.to_i]
          end
    tasks = Task.where(id: ids).all
    if tasks.present?
      s = tasks.pluck(:text).join(", ")
      Task.destroy(ids)
      reply.add "#{s} をやったぞ"
    end
  end

  def add_task
    new_task = message.strip
    Task.create(text: new_task) if new_task.present?
  end

  def show_all_tasks
    task = Task.latest
    if task.present?
      reply.add(task)
    else
      reply.add("すべてのタスクが終わってるよ")
    end
  end

  USAGE = <<MESSAGE
[usage]
タスク|task　のこりタスクを表示
タスク追加 【文章】　追加する
タスク完了 【ID】　完了する
MESSAGE
  def show_usage
    reply.add USAGE
  end

  def show_version
    reply.add "bot / Rails: #{Rails.version} (#{Rails.env})"
  end
end
