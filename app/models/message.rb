class Message < ApplicationRecord
  belongs_to :candidate_job
  belongs_to :candidate, optional: true
  belongs_to :employee, optional: true

  # after_create :update_candidate_jobs

  enum sender: {candidate:0, employee:10}

  private
    def update_candidate_jobs
      candidate_job.prop_rejected!
      candidate_job.wage = 80000
      candidate_job.save!
    end

end
