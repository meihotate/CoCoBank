class AddDeletedAtToChatmembers < ActiveRecord::Migration[5.2]
  def change
  	add_column :chatmembers, :deleted_at, :datetime
    add_index :chatmembers, :deleted_at
  end
end
