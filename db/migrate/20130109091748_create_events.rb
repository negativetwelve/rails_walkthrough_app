class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|      
        t.text :body, :default => ''
        t.string :kind
        t.integer :user_id
        t.integer :parent_event_id

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
    add_index :events, [:parent_event_id, :created_at]
  end
end
