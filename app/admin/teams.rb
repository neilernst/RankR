ActiveAdmin.register Team do

  permit_params :team_id, :team_name, :team_grade

  form do |f|
    f.inputs do
      f.input :team_id, label: 'Team Id'
      f.input :team_name, label: 'Team Name'
      f.input :team_grade, label: 'Team Grade'
    end
    f.actions
  end
  
end
