class CandidatesController < ApplicationController
    def candidate_jobs
        candidate = Candidate.find(params[:id])
        @jobs = candidate.candidate_jobs
    end
end