class Reply
  attr_accessor :token

  def initialize
    @content = nil
    @token = nil
  end

  def add(content)
    @content = content
  end

  def content
    {
      type: 'text',
      text: @content
    }
  end

  def need_to_reply?
    @content.present?
  end
end
