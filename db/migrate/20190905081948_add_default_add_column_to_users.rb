class AddDefaultAddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :degree, 0
  end
end
