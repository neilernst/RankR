class RanksController < ApplicationController
    before_action :authenticate_student!

    def new
        @team_members = current_student.team.students
    end
end
