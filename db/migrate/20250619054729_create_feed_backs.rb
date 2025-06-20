class CreateFeedBacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feed_backs do |t|
      t.date :date
      t.integer :ep
      t.integer :tf
      t.integer :con
      t.integer :mtv

      t.timestamps
    end
  end
end
