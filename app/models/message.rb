class Message
  def self.detect!(message)
    msg = message
    result = nil
    # TODO: 正規表現などで置き換えたい
    if msg.include? "タスク追加"
      result = :add
      msg.remove! "タスク追加"
    elsif msg.include? 'タスク完了'
      result = :done
      msg.remove! "タスク完了"
    elsif msg.include? 'タスク使い方'
      result = :usage
    elsif msg.include?('タスク') || msg.upcase.include?("TASK")
      result = :all
    end
    yield result if block_given? && result
    result
  end
end
