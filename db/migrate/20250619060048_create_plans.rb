class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.date :date
      t.integer :num
      t.integer :time

      t.timestamps
    end
  end
end
