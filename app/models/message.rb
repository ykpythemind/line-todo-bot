class Message
  def initialize(message)
    @message = message
  end

  def self.detect!(message, &block)
    new(message).detect!(&block)
  end

  def detect!
    result = nil
    # TODO: 正規表現などで置き換えたい
    if @message.include? "タスク追加"
      result = :add
      @message.remove! "タスク追加"
    elsif @message.include? 'タスク完了'
      result = :done
      @message.remove! "タスク完了"
    elsif @message.include? 'タスク使い方'
      result = :usage
    elsif @message.include?('タスク') || @message.upcase.include?("TASK")
      result = :all
    elsif @message.include? 'version'
      result = :version
    end
    yield result if block_given? && result
    result
  end
end
