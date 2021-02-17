class JobsController < ApplicationController
    before_action :authenticate_employee!

    def index

        @jobs = Job.all
    end

    def new
        @jobs = Job.new
    end

    def create
        @job = Job.new(job_params)
        @job.status = 'active'

        # employee = Employee.find(current_employee.time_sheets)
        @job.company = current_employee.company
        @job.save
        redirect_to job_path(@job)
    end

    def show
        @job = Job.find(params[:id])
    end

    def edit
        @job = Job.find(params[:id])
        redirect_to jobs_path notice("Cannot edit this job!") unless current_employee.company =  job.company

    end

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
            redirect_to job_path(@job)
        else
            render 'edit'
        end
    end

    private
        def job_params
            params.require(:job).permit(:title, :description, :wage, :level, :requirements, :quantity, :date)
        end

end