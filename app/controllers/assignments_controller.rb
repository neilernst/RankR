class AssignmentsController < ApplicationController
    before_action :authenticate_student!

    def index
        @assignments = current_student.assignments
    end
end
