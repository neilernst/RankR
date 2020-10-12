class AssignmentsStudent < ApplicationRecord
    belongs_to :student
    belongs_to :assignment

    GRADES = {
        "excellent" => 100, "very_good" => 87.5, "satisfactory" => 75, "ordinary" => 62.5,
        "marginal" => 50, "deficient" => 37.5, "unsatisfactory" => 25, "superficial" => 12.5,
        "no_show" => 0
    }


    def self.calculate_score(student_id, assignment_id)
        grade = self.find_by(assignment_id: assignment_id, student_id: student_id)
        grade = self.calculate_individual_average(grade)
        grade = self.calculate_adjustment_factor(grade)
        grade = self.calculate_individual_project_grade(grade)
        grade = self.calculate_individual_grade(grade)
        return self.find_by(assignment_id: assignment_id, student_id: student_id)
    end

    def self.calculate_individual_average(grade)
        sum = 0
        ratings = grade.student.received_ranks.pluck(:rating)
        ratings.each do |rating|
            sum += GRADES[rating]
        end
        individual_average = sum == 0 ? 0 : (sum / ratings.length()).round(2)
        grade.update(individual_average: individual_average)
        return grade
    end

    def self.calculate_adjustment_factor(grade)
        adj_fac_cap = grade.assignment.adjustment_factor_cap
        team_avg = grade.student.team.team_average
        adj_factor = (grade.individual_average / team_avg).round(2)
        adj_factor = adj_factor > adj_fac_cap ? adj_factor : adj_fac_cap
        grade.update(adjustment_factor: adj_factor)
        return grade
    end

    def self.calculate_individual_project_grade(grade)
        ind_proj_grade = (grade.individual_average * grade.adjustment_factor).round(2)
        ind_proj_grade = ind_proj_grade > 100 ? 100 : ind_proj_grade
        grade.update(individual_project_grade: ind_proj_grade)
        return grade
    end

    def self.calculate_individual_grade(grade)
        ind_grade = (grade.student.team.team_grade * grade.adjustment_factor).round(2)
        ind_grade = ind_grade > grade.assignment.full_grade ? grade.assignment.full_grade : ind_grade
        grade.update(individual_grade: ind_grade)
        return grade
    end
end
