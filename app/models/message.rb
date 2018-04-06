class Message
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def self.detect!(message, &block)
    new(message).detect!(&block)
  end

  def detect!
    result = nil
    @message.strip!
    if @message.match(/\A(タスク追加)/)
      result = :add
      @message.remove! $~[1]
      @message.remove! /\s|　/
    elsif @message.match(/\A(タスク)(完.+?|おわ.+?|終.+?)\s?/)
      result = :done
      @message.remove! "#{$~[1]}#{$~[2]}"
      @message.remove! /\s|　/
    elsif @message.match(/\A(タスク(使.+?|ヘルプ|？|\?)|help)/)
      result = :usage
    elsif @message.match(/\A(タスク|task|たすく)\z/)
      result = :all
    elsif @message.include? 'version'
      result = :version
    end
    yield result if block_given? && result
    result
  end
end
