class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|

      t.string :team_id, null: false
      t.string :team_name
      t.float :team_average

      t.timestamps
    end
  end
end
