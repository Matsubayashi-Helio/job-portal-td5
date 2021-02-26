class CandidatesController < ApplicationController
    before_action :authenticate_candidate!, only: [:candidate_jobs]

    def candidate_jobs
        @candidate = Candidate.find(params[:id])
        @jobs = @candidate.candidate_jobs
    end
end