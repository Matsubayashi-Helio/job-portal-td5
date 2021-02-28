class MessagesController < ApplicationController
    def create

        puts params
        cj = CandidateJob.find(params[:message][:candidate_job])
        # cj.update!(status: params[:candidate_job][:status])
 
        cj.status = params[:message][:status]
        # cj.test!(cj)
        cj.save!

 
        msg = Message.new(candidate_job: cj , sender: params[:message][:sender], 
                        sent_message: params[:message][:sent_message], 
                        candidate: current_candidate )
        if msg.candidate?
            msg.candidate = current_candidate
            redirect_to job_applied_candidate_job_path(current_candidate, cj.job)
        else
            msg.employee = current_employee
            redirect_to applicants_job_path(cj.job)
        end

        msg.save


    end


    # candidate_job, candidate, employee, sender, sent_message
    # private
    #     def message_params
    #         params.require(:message).permit(:candidate_job, :sent_message)
    #         # params.require(:message).permit(:candidate_job, :sent_message, :sender, :candidate, :employee)
    #     end

    #     def candidate_job_params
    #         params.require(:candidate_job).permit(:status)
    #     end
end