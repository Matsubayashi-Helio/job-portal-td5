class Job < ApplicationRecord
  belongs_to :company

  has_many :candidate_jobs
  has_many :candidates, through: :candidate_jobs

  enum status: {active: 0, inactive: 10}
end
