class Message < ApplicationRecord
  belongs_to :candidate_job
  belongs_to :candidate, optional: true
  belongs_to :employee, optional: true
end
