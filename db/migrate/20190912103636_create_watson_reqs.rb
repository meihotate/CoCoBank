class CreateWatsonReqs < ActiveRecord::Migration[5.2]
  def change
    create_table :watson_reqs do |t|
      t.integer :user_id
      t.text :text1, null: false, default: ""
      t.text :text2, null: false, default: ""
      t.text :text3, null: false, default: ""
      t.text :text4, null: false, default: ""
      t.text :text5, null: false, default: ""
      t.text :text6, null: false, default: ""
      t.text :text7, null: false, default: ""
      t.text :text8, null: false, default: ""
      t.text :text9, null: false, default: ""
      t.text :text10, null: false, default: ""

      t.timestamps
    end
  end
end
