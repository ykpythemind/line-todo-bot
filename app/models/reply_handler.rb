class ReplyHandler
  attr_reader :text, :reply

  def initialize(text, reply_obj)
    @text = text
    @reply = reply_obj
  end

  def detect!
    if text.include? "タスク追加"
      add_to_db
    elsif text.include? "タスク"
      reply_all_task
    end
  end

  private

  def add_to_db
  end

  def reply_all_task
    reply.add(text)
  end
end
