class Task < ApplicationRecord
  def self.latest
    tasks = Task.all
    tasks.map { |t| "[#{t.id}] #{t.text}" }.join(' | ')
  end
end
