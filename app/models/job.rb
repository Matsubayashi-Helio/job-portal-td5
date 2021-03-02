class Job < ApplicationRecord
  belongs_to :company

  has_many :candidate_jobs
  has_many :candidates, through: :candidate_jobs
 
  validates :title, :description, :level, :requirements, :quantity, :date, presence: true

  enum status: {active: 0, inactive: 10}

  def hire!
    if quantity >=0
      qnt = quantity - 1
      update(quantity: qnt)
    else
      errors.add(:quantity, message: 'Limite de vagas atingido!')
    end
  end

end
