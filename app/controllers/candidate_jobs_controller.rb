class CandidateJobsController < ApplicationController
    
    # TODO Must not allow wage and beginning_date if :rejected
    # TODO Message must be obligatory
    
    def update
        # puts params
        candidate_job = CandidateJob.find(params[:id])
        candidate_job.update!(candidate_job_params)
        
        if params[:reject]
            candidate_job.rejected!
        else
            candidate_job.prop_send!
        end

        candidate_job.save!
        redirect_to applicants_job_path(candidate_job)
    end





    private

        def candidate_job_params
            params.require(:candidate_job).permit(:message, :wage, :beginning_date, :status)
        end
end