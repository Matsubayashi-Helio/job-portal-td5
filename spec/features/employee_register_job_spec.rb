require 'rails_helper'

feature 'Employee register job' do
    scenario 'and must be signed in' do
        visit root_path
        click_on 'Registre-uma-vaga'

        expect(current_path).to eq new_employee_session_path
    end

    scenario 'from index page' do
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company, role: 'Coordenadora RH', admin: true)

        login_as(employee, :scope => :employee)
        visit root_path
        click_on 'Registre-uma-vaga'
        

        expect(current_path).to eq new_job_path
    end

    # TODO Job status by default active
    # TODO job.company = employee.company
    scenario 'successfully' do
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company, role: 'Coordenadora RH', admin: true)

        login_as(employee, :scope => :employee)
        visit root_path
        click_on 'Registre-uma-vaga'

        fill_in 'Title', with: 'IT support'
        fill_in 'Description', with:'Will act as a front line man on repairs'
        fill_in 'Wage', with: 3000
        fill_in 'Level', with: 'Junior'
        fill_in 'Requirements', with: 'Good with people, self-taught, proactive'
        fill_in 'Quantity', with: 2
        fill_in 'Date', with: '31/12/2050'
        click_on 'Submit'

        job = Job.last
        # expect(job).to exist
        expect(job.status).to eq 'active'
        expect(job.company).to eq company
        expect(current_path).to eq job_path(job)
        expect(page).to have_content('IT support')
        expect(page).to have_content('Will act as a front line man on repairs')
        expect(page).to have_content('3000')
        expect(page).to have_content('Junior')
        expect(page).to have_content('Good with people, self-taught, proactive')
        expect(page).to have_content('31/12/2050')
        expect(page).to have_content('2')
        expect(page).to have_content('IT Consulting')
    end
end