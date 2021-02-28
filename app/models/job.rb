class Job < ApplicationRecord
  belongs_to :company

  has_many :candidate_jobs
  has_many :candidates, through: :candidate_jobs
 
  # validate :limit_date

  enum status: {active: 0, inactive: 10}

  def limit_date
    if date < Date.today
      errors.add(:date, message: 'Data limite para aplicação ultrapassou.')
    end
  end
end
