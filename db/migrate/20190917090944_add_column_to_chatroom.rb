class AddColumnToChatroom < ActiveRecord::Migration[5.2]
  def change
  	add_column :chatrooms, :accesstime, :datetime, :default => DateTime.now, :null => false
  end
end
