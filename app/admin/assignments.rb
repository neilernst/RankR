ActiveAdmin.register Assignment do

  permit_params :year, :course, :name, :status, 
  :adjustment_factor_cap, :deadline, :full_grade
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
    assignment = Assignment.find(params[:id])
    ranks = assignment.ranks
    render 'teams', {
      teams: teams, ranks: ranks, 
      assignment: assignment
    }
  end
end
