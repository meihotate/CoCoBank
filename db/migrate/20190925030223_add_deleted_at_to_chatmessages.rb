class AddDeletedAtToChatmessages < ActiveRecord::Migration[5.2]
  def change
  	add_column :chatmessages, :deleted_at, :datetime
    add_index :chatmessages, :deleted_at
  end
end
