ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    teams = Team.all
    assignments = Assignment.all.order(id: :asc)
    render 'main', {
      assignments: assignments
    }
  end
end
