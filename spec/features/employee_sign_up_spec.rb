require 'rails_helper'

feature 'Employee sign up' do

    scenario 'for an existing company' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')


        visit root_path
        click_on 'Signup'
        fill_in 'Email', with: 'ana@itc.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        fill_in 'Role', with: 'Coordenadora de RH'
        fill_in 'First name', with: 'Ana'
        fill_in 'Last name', with: 'Silva'
        within('form') do
            click_on 'Signup'
        end

        employee = Employee.last
        expect(employee).to exist
        expect(current_path).not_to eq new_employee_registration_path
        expect(page).to have_content('Olá, Ana!')
    end

    feature 'for the first time for a new company' do
        scenario 'and requires company information' do
            visit root_path
            click_on 'Signup'
            fill_in 'Email', with: 'ana@itc.com'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: '123456'
            fill_in 'Role', with: 'Coordenadora de RH'
            fill_in 'First name', with: 'Ana'
            fill_in 'Last name', with: 'Silva'
            within('form') do
                click_on 'Signup'
            end

            expect(Employee.last).to exists?
            expect(current_path).to eq new_company_path
            expect(page).to have_content('Preencha dados da companhia')
        end

        scenario 'successfully' do
            visit root_path
            click_on 'Signup'
            fill_in 'Email', with: 'ana@itc.com'
            fill_in 'Password', with: '123456'
            fill_in 'Password confirmation', with: '123456'
            fill_in 'Role', with: 'Coordenadora de RH'
            fill_in 'First name', with: 'Ana'
            fill_in 'Last name', with: 'Silva'
            within('form') do
                click_on 'Signup'
            end

            fill_in 'Razão Social', with: 'IT Consulting'
            fill_in 'CNPJ', with: '13363706000106'
            click_on 'Register'

            expect(current_path).to eq root_path
            expect(page).to have_link('Sair')
            expect(page).not_to have_link('Entrar')
            expect(page).to have_content('Olá, Ana!')
        end
    end
end