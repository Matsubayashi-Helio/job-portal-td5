require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:role)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}

    it {should validate_uniqueness_of(:email).case_insensitive}
  end
end
