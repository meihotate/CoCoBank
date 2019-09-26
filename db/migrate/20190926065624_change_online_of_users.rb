class ChangeOnlineOfUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :online, "false"
  end
end
