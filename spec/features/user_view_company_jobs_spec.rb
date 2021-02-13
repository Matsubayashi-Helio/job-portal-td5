require 'rails_helper'

# TODO Refactor - specify tags for the tests
feature "User view company's jobs" do
    
    scenario 'successfully' do
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

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                        wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                        quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        job_xcode = Job.create!(title: 'Map Designer', description:'Will be responsible to create and modify layouts for the levels for the projects', 
                        wage:'6000', level: 'junior', requirements: 'Self-taught, proactive, creative, must have previous experience on the job', 
                        quantity: 4, date:'31/12/2050', status: 'active', company: company_xcode)

        visit root_path
        click_on 'Empresas Cadastradas'
        click_on 'IT Consulting'
        click_on 'Ver vagas'

        expect(current_path).to eq company_jobs_company_path(company_itc)
        expect(page).to have_content('IT support')
        expect(page).to have_content('Will act as a front line man on repairs')
        expect(page).to have_content('3000')
        expect(page).to have_content('junior')
        expect(page).to have_content('Good with people, self-taught, proactive')
        expect(page).to have_content('31/12/2050')
        expect(page).to have_content('2')
        expect(page).to have_content('IT Consulting')

        expect(page).not_to have_content('Map Designer')
        expect(page).not_to have_content('Will be responsible to create and modify layouts for the levels for the projects')
        expect(page).not_to have_content('6000')
        expect(page).not_to have_content('Self-taught, proactive, creative, must have previous experience on the job')
        expect(page).not_to have_content('XCode Entertainment')
        expect(page).not_to have_content('4')
    end

    # TODO attributes can have same value but test still pass if status inactive
    # TODO change to status be active by default(see https://youtu.be/cHcEZh3WNy4?list=PLajdzeQ7QG3gMfKyI-d0_XaT8J7kryDGm&t=8206)
    scenario 'and inactive jobs must not be visible' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        active_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                                    wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                                    quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        inactive_job_itc = Job.create!(title: 'IT Manager', description:'Will be responsible for the infrastructure team on the deployment of new sites', 
                                    wage:'10000', level: 'Manager', 
                                    requirements: 'Good with people, proactive, must have previous experience on the job, available for travel', 
                                    quantity: 1, date:'31/12/2049', status: 'inactive', company: company_itc)

        visit company_jobs_company_path(company_itc)

        expect(page).not_to have_content('IT Manager')
        expect(page).not_to have_content('Will be responsible for the infrastructure team on the deployment of new sites')
        expect(page).not_to have_content('10000')
        expect(page).not_to have_content('Manager')
        expect(page).not_to have_content('Good with people, proactive, must have previous experience on the job, available for travel')
        expect(page).not_to have_content('31/12/2049')
        within("dd#job-quantity") do
            expect(page).not_to have_content('1')
        end
    end

    scenario 'and must not see jobs past the limit date' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        active_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                                    wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                                    quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        inactive_job_itc = Job.create!(title: 'IT Manager', description:'Will be responsible for the infrastructure team on the deployment of new sites', 
                                    wage:'10000', level: 'Manager', 
                                    requirements: 'Good with people, proactive, must have previous experience on the job, available for travel', 
                                    quantity: 1, date:'31/12/2020', status: 'active', company: company_itc)

        visit company_jobs_company_path(company_itc)

        expect(page).not_to have_content('IT Manager')
        expect(page).not_to have_content('Will be responsible for the infrastructure team on the deployment of new sites')
        expect(page).not_to have_content('10000')
        expect(page).not_to have_content('Manager')
        expect(page).not_to have_content('Good with people, proactive, must have previous experience on the job, available for travel')
        expect(page).not_to have_content('31/12/2020')
        within("dd#job-quantity") do
            expect(page).not_to have_content('1')
        end
    end
end