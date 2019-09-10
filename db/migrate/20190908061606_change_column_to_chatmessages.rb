class ChangeColumnToChatmessages < ActiveRecord::Migration[5.2]
  def change
  	rename_column :chatmessages, :user_id, :chatroom_id
  end
end
