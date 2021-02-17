require 'rails_helper'

feature 'Employees edit a job' do
    scenario 'and employee is signed in' do
        visit root_path
        click_on 'Ver-vagas'

        expect(current_path).to eq new_employee_session_path
    end

    scenario 'successfully' do
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company, role: 'Coordenadora RH', admin: true)

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                        wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                        quantity: 2, date:'31/12/2050', status: 'active', company: company)

        login_as employee
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Editar'

        fill_in 'Title', with: 'IT support junior'
        fill_in 'Description', with: 'Will act as a front line man on repairs. May need to work on weekends.'
        fill_in 'Wage', with: '2500'
        fill_in 'Level', with: 'Junior I'
        fill_in 'Requirements', with: 'Good with people, self-taught, proactive. Previous experience is a plus.'
        fill_in 'Quantity', with: '3'
        fill_in 'Date', with: '31/12/2025'
        click_on 'Editar'

        expect(current_path).to eq job_path(job_itc)
        expect(page).to have_content('IT support junior')
        expect(page).to have_content('Will act as a front line man on repairs. May need to work on weekends.')
        expect(page).to have_content('2500')
        expect(page).to have_content('Junior I')
        expect(page).to have_content('Good with people, self-taught, proactive. Previous experience is a plus.')
        within('dd#quantity') do
            expect(page).to have_content('3')
        end
        expect(page).to have_content('31/12/2025')

    end

    scenario 'and only employees of the company can edit job' do
        
    end

end