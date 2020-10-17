class AddTeamGradeToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :team_grade, :float, default: 0.0
    add_column :assignments_students, :individual_grade, :float, default: 0.0
    add_column :assignments, :full_grade, :float, default: 0.0
  end
end
