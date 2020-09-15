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
        return grade
    end

    def self.calculate_individual_average(grade)
        sum = 0
        ratings = grade.student.received_ranks.pluck(:rating)
        ratings.each do |rating|
            sum += GRADES[rating]
        end
        individual_average = sum / ratings.length()
        grade = grade.update(individual_average: individual_average)
        return grade
    end
end
