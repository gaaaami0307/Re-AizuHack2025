class CreateInputs < ActiveRecord::Migration[7.1]
  def change
    create_table :inputs do |t|
      t.date :date
      t.string :emotion
      t.float :maxtime

      t.timestamps
    end
  end
end
