require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:cnpj)}
    it {should validate_presence_of(:site)}
    it {should validate_presence_of(:social_network)}
    it {should validate_presence_of(:about)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:email_provider)}

    it {should validate_uniqueness_of(:cnpj)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_uniqueness_of(:email_provider)}
    it {should validate_uniqueness_of(:address)}

    it {should validate_numericality_of(:cnpj)}
  end

  describe 'associations' do
    it {should have_many(:job).class_name('Job')}
    it {should have_one_attached(:cover)}

  end
end
