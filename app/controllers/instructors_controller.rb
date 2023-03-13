class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :invalid
rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def not_found
        render json: {"error": "Instructor not found"}, status: 404
    end

    def invalid
        render json: {"errors": ["validation errors"]}, status: 422
    end
end
