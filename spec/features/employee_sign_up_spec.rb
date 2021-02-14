require 'rails_helper'

feature 'Employee sign up' do
    scenario 'without company registered' do
        
        visit root_path
        click_on 'Para Empresas'
        click_on 'Sign up'
        fill_in 'Email', with: 'ana@itc.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Cargo', with: 'Coordenadora de RH'
        fill_in 'Nome', with: 'Ana'
        fill_in 'Sobrenome', with: 'Silva'
        click_on 'Register'

        fill_in 'CNPJ', with: '13363706000106'
        fill_in 'Nome Social', with: 'IT Counsulting'

        expect(page).to have_content('Olá, Ana!')
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Entrar')
    end

    scenario 'with company registered' do
        visit root_path
        click_on 'Para Empresas'
        click_on 'Sign up'
        fill_in 'Email', with: 'ana@itc.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Cargo', with: 'Coordenadora de RH'
        fill_in 'Nome', with: 'Ana'
        fill_in 'Sobrenome', with: 'Silva'
        click_on 'Register'

        expect(current_path).not_to eq new_company_path
        expect(page).to have_content('Olá, Ana!')
    end
end