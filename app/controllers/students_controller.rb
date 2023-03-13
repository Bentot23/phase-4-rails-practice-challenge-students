class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid
rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :ok
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit( :name, :major, :age, :instructor_id )
    end

    def not_found
        render json: {"error": "Instructor not found"}, status: 404
    end

    def invalid
        render json: {"errors": ["validation errors"]}, status: 422
    end
    
end
