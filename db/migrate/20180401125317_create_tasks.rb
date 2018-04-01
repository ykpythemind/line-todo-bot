class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :text
      t.datetime :deadline

      t.timestamps
    end
  end
end
