class RanksController < ApplicationController
    before_action :authenticate_student!

    def index
        # @team_members = current_student.team.students
        # @given_ranks = Rank.where(ranker_id: current_student.id)
        # @assignment = Assignment.find(params[:assignment_id])
    end

    def new
        @team_members = current_student.team.students
        @assignment = Assignment.find(params[:assignment_id])
        @ranks = []
        @team_members.each do |team_member|
            @ranks << @assignment.ranks.new(ranker_id: current_student.id, receiver_id: team_member.id)
        end
    end

    def create
        @params = ranks_params
        @params[:ratings].each do |receiver_id, rank|
            Rank.create(assignment_id: @params[:assignment_id], ranker_id: current_student.id,
            receiver_id: receiver_id, rating: rank, comment: @params[:comments][receiver_id])
        end
        redirect_to assignment_ranks_path(@params[:assignment_id])
    end

    private

    def ranks_params
        params.require(:ranks).permit!
    end
end
