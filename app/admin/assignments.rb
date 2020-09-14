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
    render 'teams', { teams: teams, ranks: ranks}
  end

end
