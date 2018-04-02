class Reply
  def initialize
    @stack = []
  end

  def add(text)
    @stack.push text
  end

  def content
    @stack.map do |s|
      { type: 'text', text: s }
    end
  end

  def need_to_reply?
    @stack.present?
  end
end
