class Task < ApplicationRecord
  def self.latest
    tasks = Task.take(3)
    tasks.map { |t| "[#{t.id}] #{t.text}" }.join(' | ')
  end
end
