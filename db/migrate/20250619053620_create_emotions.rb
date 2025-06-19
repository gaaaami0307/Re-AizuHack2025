class CreateEmotions < ActiveRecord::Migration[7.1]
  def change
    create_table :emotions do |t|
      t.date :date
      t.float :positive
      t.float :neutral
      t.float :negative

      t.timestamps
    end
  end
end
