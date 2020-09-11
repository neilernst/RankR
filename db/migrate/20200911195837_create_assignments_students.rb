class CreateAssignmentsStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments_students do |t|
      t.belongs_to :student
      t.belongs_to :assignment
      t.timestamps
    end
  end
end
