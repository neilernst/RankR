class RanksController < ApplicationController
    before_action :authenticate_student!

    def show
        @team_members = current_student.team.students
        @given_ranks = Rank.where(ranker_id: current_student.id)
    end

    def new
        @team_members = current_student.team.students
        print @team_members
        @ranks = []
        @team_members.each do |team_member|
            @ranks << Rank.new(ranker_id: current_student.id, receiver_id: team_member.id)
        end
    end

    def create
        @params = ranks_params
        @params.each do |receiver_id, rank|
            Rank.create(ranker_id: current_student.id, receiver_id: receiver_id, rating: rank)
        end
        redirect_to rank_path
    end

    private

    def ranks_params
        params.require(:ranks).permit!
    end
end
