require 'rails_helper'

RSpec.describe Job, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:requirements) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it{ should have_many(:candidate_jobs).class_name('CandidateJob')}
  end
end