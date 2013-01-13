class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :event_id
      t.timestamps
    end
    add_index :likes, [:user_id, :created_at]
    add_index :likes, [:event_id, :created_at]
  end
end
