class AddDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :current_sign_in_at, :datetime, :default => DateTime.now, :null => false
  end
end
