class JobsController < ApplicationController
    before_action :authenticate_employee!, only: [:new, :create, :edit, :update]

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
        job = Job.find(params[:id])
        if current_employee.company != job.company
            # notice("Cannot edit this job!")
            redirect_to jobs_path 
        else
            @job = Job.find(params[:id])
        end

    end

    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
            redirect_to job_path(@job)
        else
            render 'edit'
        end
    end

    def apply
        candidate = Candidate.find(current_candidate.id)
        job = Job.find(params[:id])
            
        if job.inactive?
            # notice('Cannot apply for job')
            redirect_to job, notice:'Cannot apply for jobs'
            return
        end
        CandidateJob.create!(candidate: candidate, job:job, status:'pending')
        redirect_to job_applied_candidate_job_path(candidate, job)
    end

    def job_applied
        candidate = Candidate.find(params[:candidate_id])
        # @cjobs = candidate.candidate_jobs
        @jobs = candidate.candidate_jobs
    end

    def applicants
        job = Job.find(params[:id])
        @applicants = job.candidate_jobs
    end

    # TODO Look for better way to find status on candidate_jobs
    def applicant
        @candidate = Candidate.find(params[:candidate_id])
        @candidate_jobs =  @candidate.candidate_jobs.find_by(job_id: params[:id])
        # puts @candidate_jobs.status
    end

    private
        def job_params
            params.require(:job).permit(:title, :description, :wage, :level, :requirements, :quantity, :date)
        end

end