class RanksController < ApplicationController
    before_action :authenticate_student!

    def index; end

    def new
        if current_student.has_already_ranked_for(params[:assignment_id])
            redirect_to assignment_ranks_path(params[:assignment_id])
        end
        @team_members = current_student.team.students
        @assignment = Assignment.find(params[:assignment_id])
        @ranks = []
        @team_members.each do |team_member|
            @ranks << @assignment.ranks.new(
                ranker_id: current_student.id, 
                receiver_id: team_member.id
            )
        end
    end

    def create
        unless current_student.has_already_ranked_for(ranks_params[:assignment_id])
            ranks_params[:ratings].each do |receiver_id, rank|
                if current_student.can_rank?(receiver_id)
                    Rank.create(
                        assignment_id: ranks_params[:assignment_id], 
                        ranker_id: current_student.id,
                        receiver_id: receiver_id, 
                        rating: rank.to_i, 
                        comment: ranks_params[:comments][receiver_id]
                    )
                end
            end
        end
        redirect_to assignment_ranks_path(ranks_params[:assignment_id])
    end

    private

    def ranks_params
        params.require(:ranks).permit!
    end
end
