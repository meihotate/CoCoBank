class CreateWatsonReqs < ActiveRecord::Migration[5.2]
  def change
    create_table :watson_reqs do |t|
      t.integer :user_id
      t.text :text1
      t.text :text2
      t.text :text3
      t.text :text4
      t.text :text5
      t.text :text6
      t.text :text7
      t.text :text8
      t.text :text9
      t.text :text10

      t.timestamps
    end
  end
end
