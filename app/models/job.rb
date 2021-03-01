class Job < ApplicationRecord
  belongs_to :company

  has_many :candidate_jobs
  has_many :candidates, through: :candidate_jobs
 
  # validate :quantity_available

  enum status: {active: 0, inactive: 10}

  def limit_date
    if date < Date.today
      errors.add(:date, message: 'Data limite para aplicação ultrapassou.')
    end
  end

  def hire!
    if quantity >=0
      qnt = quantity - 1
      update(quantity: qnt)
    else
      errors.add(:quantity, message: 'Limite de vagas atingido!')
    end
  end

  def quantity_available
    if quantity == 0
      errors.add(:quantity, message: 'Não é possível se candidatar! Limite de vagas foi atingido.')
    end
  end

end
