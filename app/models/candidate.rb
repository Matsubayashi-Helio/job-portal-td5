class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :candidate_jobs
  has_many :jobs, through: :candidate_jobs

  validates :email, :first_name, :last_name, :cpf, :phone, :bio, presence: true
  validates :email, :cpf, :phone, uniqueness: {case_sensitive: false}
  validates :cpf, :phone, numericality: {only_integer: true}
end
