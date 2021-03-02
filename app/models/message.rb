class Message < ApplicationRecord
  belongs_to :candidate_job
  belongs_to :candidate, optional: true
  belongs_to :employee, optional: true

  # after_create :update_candidate_jobs

  enum sender: {candidate:0, employee:10}

  

end
