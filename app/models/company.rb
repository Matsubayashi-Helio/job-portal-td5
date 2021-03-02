class Company < ApplicationRecord
    has_one_attached :cover
    has_many :job

    validates :name, :cnpj, :site, :social_network, :about, :address, :email_provider, presence: true
    validates :cnpj, :name, :email_provider, :address, uniqueness: true
    validates :cnpj, numericality: {only_integer: true}
end
