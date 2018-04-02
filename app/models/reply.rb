class Reply
  def initialize
    @text = nil
  end

  def add(text)
    @text = text
  end

  def content
    {
      type: 'text',
      text: @text
    }
  end

  def need_to_reply?
    @text.present?
  end
end
