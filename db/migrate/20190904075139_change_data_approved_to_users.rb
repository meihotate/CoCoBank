class ChangeDataApprovedToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :approved, :integer
  end
end
