class ReplyHandler
  attr_reader :message, :reply

  HELP = <<MESSAGE
[usage]
タスク|task　のこりタスクを表示
タスク追加 【文章】　追加する
タスク完了 【ID】　完了する
MESSAGE

  def initialize(message, reply_obj)
    @message = message
    @reply = reply_obj
  end

  def detect!
    if message.include? "タスク追加"
      @message.remove! "タスク追加"
      add_to_db
    elsif message.include? "タスク完了"
      @message.remove! "タスク完了"
      task_done
    elsif message.include? "タスク使い方"
      reply.add HELP
    elsif message.include?("タスク") || message.upcase.include?("TASK")
      reply_all_task
    end
  end

  private

  def task_done
    raw = message.strip
    ids = if raw.include?(",")
            raw.split(',')
          else
            [raw.to_i]
          end
    tasks = Task.where(id: ids).all
    if tasks.present?
      s = tasks.all.map(&:text).join(", ")
      Task.destroy(ids)
      reply.add "#{s} をやったぞ"
    end
  end

  def add_to_db
    new_task = message.strip
    Task.create(text: new_task) if new_task.present?
  end

  def reply_all_task
    task = Task.latest
    if task.present?
      reply.add(task)
    else
      reply.add("すべてのタスクが終わってるよ")
    end
  end
end
