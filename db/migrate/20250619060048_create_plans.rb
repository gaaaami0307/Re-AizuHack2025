class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.date :date
      t.integer :ep
      t.integer :num
      t.integer :time
      t.boolean :finished

      t.timestamps
    end
  end
end
