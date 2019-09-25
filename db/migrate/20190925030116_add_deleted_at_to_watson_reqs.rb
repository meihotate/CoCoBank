class AddDeletedAtToWatsonReqs < ActiveRecord::Migration[5.2]
  def change
  	add_column :watson_reqs, :deleted_at, :datetime
    add_index :watson_reqs, :deleted_at
  end
end
