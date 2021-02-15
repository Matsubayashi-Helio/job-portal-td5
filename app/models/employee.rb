class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company, optional: true

  validates :first_name, :last_name, :role, :email, :password, presence: true

  def company_email
    email_provider = email
    email_provider[0,email.index("@")] = ""
  end


  def test
    email = "@test.com"
  end
end
