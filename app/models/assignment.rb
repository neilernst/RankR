class Assignment < ApplicationRecord
    has_many :ranks
    has_and_belongs_to_many :students
end
