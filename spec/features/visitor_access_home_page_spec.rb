require 'rails_helper'

feature 'Visitor access home page' do
    scenario 'successfully' do
        visit root_path

        expect(page).to have_content('Job Portal')
        expect(page).to have_content('Welcome to the portal where you can find the jod you always wanted!')
    end
end