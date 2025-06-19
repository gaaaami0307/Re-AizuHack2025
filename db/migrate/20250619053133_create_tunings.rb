class CreateTunings < ActiveRecord::Migration[7.1]
  def change
    create_table :tunings do |t|
      t.integer :ep
      t.float :T
      t.float :M
      t.float :C

      t.timestamps
    end
  end
end
