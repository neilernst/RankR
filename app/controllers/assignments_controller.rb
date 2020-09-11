class AssignmentsController < ApplicationController
    before_action :authenticate_student!

    def index
        @assignment = Assignment.first
    end
end
