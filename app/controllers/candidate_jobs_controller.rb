class CandidateJobsController < ApplicationController
    def update
        # puts params
        candidate_job = CandidateJob.find(params[:id])
        if params[:reject]
            candidate_job.update(candidate_job_params)
            candidate_job.status = 'rejected'
        end

        candidate_job.save
        redirect_to applicants_job_path(candidate_job)
    end





    private

        def candidate_job_params
            params.require(:candidate_job).permit(:message, :wage, :beginning_date, :status)
        end
end