class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.integer :ranker_id
      t.integer :receiver_id
      t.integer :rating

      t.timestamps
    end
  end
end
