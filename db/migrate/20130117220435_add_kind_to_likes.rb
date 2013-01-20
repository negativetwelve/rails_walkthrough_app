class AddKindToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :kind, :string
  end
end
