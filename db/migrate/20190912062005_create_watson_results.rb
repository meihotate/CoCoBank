class CreateWatsonResults < ActiveRecord::Migration[5.2]
  def change
    create_table :watson_results do |t|

      t.integer :watson_req_id, null: false
      t.text :result, null: false

      t.timestamps
    end
  end
end
