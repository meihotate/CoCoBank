class AddDefaultApprovedToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :approved, :integer, :default => 0
  end
end
