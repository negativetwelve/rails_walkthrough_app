class AddReceiverIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :receiver_id, :integer
  end
end
