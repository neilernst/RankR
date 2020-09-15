ActiveAdmin.register Assignment do

  permit_params :year, :course, :name, :status, :deadline
  #
  # or
  #
  # permit_params do
  #   permitted = [:year, :course, :name, :status, :deadline]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  show do
    teams = Team.all
    ranks = Rank.where(assignment_id: params[:id]).joins(:students).joins(:ranks)
    assignment = Assignment.find(params[:id])
    teams.each do |team|
      team.students do |student|
        AssignmentsStudent.calculate_score(student.id, assignment.id)
      end
      team.calculate_team_average(assignment.id)
    end
    render 'teams', {
      teams: teams, ranks: ranks, 
      assignment: assignment
    }
  end
end
