class RemoveCounselorFlagFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :counselor_flag, :boolean
  end
end
