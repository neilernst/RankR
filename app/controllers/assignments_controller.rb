class AssignmentsController < ApplicationController
    before_action :authenticate_student!, only: [:index]
    before_action :authenticate_admin_user!, only: [:show]

    def index
        @assignments = current_student.assignments
    end

    def show
        teams = Team.all
        ranks = Rank.where(assignment_id: params[:id]).joins(:students).joins(:ranks)
        assignment = Assignment.find(params[:id])
        teams.each do |team|
        team.students.each do |student|
            AssignmentsStudent.calculate_score(student.id, assignment.id)
        end
        team = team.calculate_team_average(assignment.id)
        end
        redirect_to admin_assignment_path(assignment.id)
    end
end
