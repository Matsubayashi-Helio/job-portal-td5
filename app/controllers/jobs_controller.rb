class JobsController < ApplicationController
    before_action :authenticate_employee!, only: [:new, :create, :edit, :update, :applicants]
    before_action :authenticate_candidate!, only: [:apply, :job_applied]

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
            job.errors.add(:date, status: 'Cannot apply for jobs')
            redirect_to job, notice:'Cannot apply for jobs'
            return
        end


        # TODO Errors.full_messages seems to not be working on show page. Look into it with more care
        if job.date < Date.today
            job.errors.add(:date, message: 'Data limite para aplicação ultrapassou.')
            redirect_to job, notice: 'Data limite para aplicação ultrapassou.' and return
        end

        if job.quantity == 0
            job.errors.add(:quantity, message: 'Não é possível se candidatar! Limite de vagas foi atingido.')
            
            # puts job.errors.full_messages
            redirect_to job, notice: 'Não é possível se candidatar! Limite de vagas foi atingido.' and return
        end




        CandidateJob.create!(candidate: candidate, job:job)
        redirect_to job_applied_candidate_job_path(candidate, job)
    end

    def job_applied
        candidate = Candidate.find(params[:candidate_id])
        # @cjobs = candidate.candidate_jobs
        @job = candidate.candidate_jobs.find_by(job_id: params[:id])



        @message = Message.where(candidate_job: @job)
    end

    def applicants
        job = Job.find(params[:id])
        @applicants = job.candidate_jobs
    end

    # TODO Look for better way to find status on candidate_jobs
    def applicant
        @candidate = Candidate.find(params[:candidate_id])
        @candidate_jobs =  @candidate.candidate_jobs.find_by(job_id: params[:id])
        
        @message = Message.where(candidate_job: @candidate_jobs)

    end

    private
        def job_params
            params.require(:job).permit(:title, :description, :wage, :level, :requirements, :quantity, :date)
        end

end