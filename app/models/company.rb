class Company < ApplicationRecord
    has_one_attached :cover
    has_many :job
end
