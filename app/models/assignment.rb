class Assignment < ApplicationRecord
    has_many :ranks
    has_and_belongs_to_many :students
    has_many :assignments_students

    enum status: [:inactive, :active]
end
