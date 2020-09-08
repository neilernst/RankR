class RanksController < ApplicationController
    before_action :authenticate_student!

    def new
        @team_members = current_student.team.students
        @ranks = []
        @team_members.each do |team_member|
            @ranks << Rank.new(ranker_id: current_student.id, receiver_id: team_member.id)
        end
    end
end
