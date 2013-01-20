class AddParentKindToEvents < ActiveRecord::Migration
  def change
    add_column :events, :parent_kind, :string
  end
end
