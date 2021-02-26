class MessagesController < ApplicationController


    def create

        # puts params
        
        cj = CandidateJob.find(params[:message][:candidate_job_value])
        puts cj.status
        # cj.status = params[:candidate_job][:status]
        cj.update(candidate_job_params)

        cj.save

        params[:message][:candidate_job] = cj
        # puts params[:message][:candidate_job]
        # puts message_params

        # TODO Message.new does not create the 

        # msg = Message.create!(candidate_job: cj, sender: params[:message][:sender], sent_message: params[:message][:sent_message])
        # msg = Message.create!(message_params)
        msg = Message.new(message_params)

        if msg.candidate?
            msg.candidate = current_candidate
            redirect_to job_applied_candidate_job_path(current_candidate, cj.job)
        else
            msg.employee = current_employee
            redirect_to applicants_path(cj.job)
        end

        msg.save

        

    end


    private
        def message_params
            params.require(:message).permit(:candidate_job, :sent_message, :sender, :candidate, :employee)
        end

        def candidate_job_params
            params.require(:candidate_job).permit(:status)
        end
end