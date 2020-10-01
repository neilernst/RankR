class RanksController < ApplicationController
    before_action :authenticate_student!, only: [:new, :create]
    before_action :authenticate_admin_user!, only: :show

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

    def show
        teams = Team.all
        assignment = Assignment.find(params[:id])
        ranks = assignment.ranks
        csv = []
        teams.each do |team|
            csv << [team.team_name]
            headers = ["Student Id", "Student Name"]
            for i in 1..team.students.length()
                headers.push("Vote #{i}")
            end
            headers.push("Individual Avgerage", "Team Average", "Adj. Fctr.", "Adj Factor Cap", "Individual Project Grade")
            csv << headers
            team.students.each do |student|
                row = []
                row.push(student.student_id, student.name)
                student.received_ranks.where(assignment_id: assignment.id).each do |rank|
                    row.push(rank.rating.humanize)
                end
                for i in 1..(team.students.length() - student.received_ranks.where(assignment_id: assignment.id).length())
                    row.push("N/A")
                end
                row.push(
                    assignment.assignments_students.find_by(student_id: student.id).individual_average,
                    team.team_average,
                    assignment.assignments_students.find_by(student_id: student.id).adjustment_factor,
                    assignment.adjustment_factor_cap,
                    assignment.assignments_students.find_by(student_id: student.id).individual_project_grade
                )
                csv << row
            end
        end
        file = csv.to_csv
        # File.write("#{assignment.name}", file)
        respond_to do |format|
            format.html {redirect_to admin_assignment_url(assignment.id)}
            format.csv { render :csv => csv.to_csv }
        end
        
    end

    private

    def ranks_params
        params.require(:ranks).permit!
    end
end
