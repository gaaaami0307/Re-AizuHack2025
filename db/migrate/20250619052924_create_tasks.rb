class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.date :date
      t.string :content
      t.boolean :complete

      t.timestamps
    end
  end
end
