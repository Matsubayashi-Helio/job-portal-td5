class Job < ApplicationRecord
  belongs_to :company

  enum status: {active: 0, inactive: 10}
end
