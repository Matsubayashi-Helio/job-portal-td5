require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:cpf)}
    it {should validate_presence_of(:phone)}
    it {should validate_presence_of(:bio)}

    it {should validate_uniqueness_of(:cpf)}
    it {should validate_uniqueness_of(:email).case_insensitive}
    it {should validate_uniqueness_of(:phone)}

    it {should validate_numericality_of(:cpf)}
    it {should validate_numericality_of(:phone)}
  end

  describe 'associations' do
    it {should have_many(:candidate_jobs).class_name('CandidateJob')}
  end
end
