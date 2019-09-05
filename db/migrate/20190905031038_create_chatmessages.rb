class CreateChatmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chatmessages do |t|
      t.text :message, null: false
      t.integer :chatmember_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
