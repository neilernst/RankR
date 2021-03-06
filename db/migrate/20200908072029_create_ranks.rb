class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.belongs_to :assignment
      t.integer :ranker_id
      t.integer :receiver_id
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
