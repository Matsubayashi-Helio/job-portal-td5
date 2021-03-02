class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company, optional: true

  # attr_accessor :first_name, :last_name, :role
  validates :first_name, :last_name, :role, :email, :password, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  def company_email
    email_provider = email
    email_provider[0,email.index("@")] = ""
  end


  def test
    email = "@test.com"
  end
end
