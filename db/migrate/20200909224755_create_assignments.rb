class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.string :year
      t.string :course
      t.string :name
      t.integer :status
      t.datetime :deadline
      t.timestamps
    end
  end
end
