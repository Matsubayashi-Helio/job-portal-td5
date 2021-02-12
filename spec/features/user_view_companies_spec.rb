require 'rails_helper'

feature 'User view companies' do

    # TODO Way to add arrays to the model/db
    # TODO Way to add addresses as atomic information
    # TODO CNPJ must accept zeros on the left
    scenario 'successfully' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
                                # address: {street: 'Rua dos Santos', number: 84, neighborhood: 'Vila dos Santos', city:'São Paulo', state: 'SP', complement: ''}
                                # social_network: ['facebook.com/itc', 'twitter.com/itc','instagram.com/itc']
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        company_xcode = Company.create!(name: 'XCode Entertainment', cnpj: '94221637000151', site: 'www.xcode.com', 
                                social_network: 'twitter.com/xcode', 
                                about: 'XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay',
                                address: 'Avenida XCode, 01 - São Paulo-SP, Edifício 0, 1º andar')
                                # address: {street: 'Avenida XCode', number: 01, neighborhood: 'Vila Code', city:'São Paulo', state: 'SP', complement: 'Edifício 0, 1º andar'}
                                # social_network: ['facebook.com/xcode', 'twitter.com/xcode','instagram.com/xcode']
        company_xcode.cover.attach(io: File.open(Rails.root.join('public','logo','company-xcode-logo.jfif')), filename: 'company-xcode-logo.jfif')
        
        visit root_path
        click_on 'Empresas Cadastradas'

        expect(current_path).to eq companies_path
        expect(page).to have_content('IT Consulting')
        expect(page).to have_content('IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.')
        expect(page).to have_content('XCode Entertainment')
        expect(page).to have_content('XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay')
    end

    scenario 'and view details' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        company_xcode = Company.create!(name: 'XCode Entertainment', cnpj: '94221637000151', site: 'www.xcode.com', 
                                social_network: 'twitter.com/xcode', 
                                about: 'XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay',
                                address: 'Avenida XCode, 01 - São Paulo-SP, Edifício 0, 1º andar')
        company_xcode.cover.attach(io: File.open(Rails.root.join('public','logo','company-xcode-logo.jfif')), filename: 'company-xcode-logo.jfif')

        visit companies_path
        click_on 'IT Consulting'

        expect(current_path).to eq company_path(company_itc)
        expect(page).to have_content('IT Consulting')
        expect(page).to have_css("img[src*='company_itc_logo.jfif']")
        expect(page).to have_content('13363706000106')
        expect(page).to have_content('www.itc.com')
        expect(page).to have_content('IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.')
        expect(page).to have_content('Rua dos Santos, 84 - São Paulo-SP')
        expect(page).to have_link('twitter.com/itc')

    end

    scenario 'and go back to all companies' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        visit company_path(company_itc)
        click_on 'Voltar'

        expect(current_path).to eq companies_path
    end

    scenario 'and go back to home page' do
        visit companies_path
        click_on 'Voltar'

        expect(current_path).to eq root_path
    end
end