require 'rails_helper'

feature 'Employee login' do
    scenario 'successfully' do
        user = User.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva')
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        employee = Employee.create!(user: user, company: company, role: 'Coordenadora RH', admin: true)

        visit root_path
        click_on 'Para Empresas'
        click_on 'Login'
        within('form') do
            fill_in 'Email', with: 'ana@itc.com'
            fill_in 'Password', with: '123456'
            click_on 'Log in'
        end

        expect(current_path).to eq root_path
        expect(page).to have_link('Sair')
        expect(page).not_to have_link('Entrar')
    end

    scenario 'and logout' do
        user = User.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva')
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        employee = Employee.create!(user: user, company: company, role: 'Coordenadora RH', admin: true)

        visit root_path
        login_as employee
        click_on 'Sair'

        expect(page).not_to have_link('Sair')
        expect(page).to have_link('Entrar')
    end
end