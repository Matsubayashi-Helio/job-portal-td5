require 'rails_helper'

feature 'Candidate apply for a job' do

    scenario 'successfully' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)
                            
        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        login_as candidate
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Candidatar-se'

        expect(current_path).to eq job_applied_candidate_job_path(candidate, job_itc)
        expect(page).to have_content('IT support')
        expect(page).to have_content('Will act as a front line man on repairs')
        expect(page).to have_content('IT Consulting')
        expect(page).to have_content('pending')


    end


    scenario 'and see all jobs applied' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        rejected_job_itc = Job.create!(title: 'IT Manager', description:'Will be responsible for the infrastructure team on the deployment of new sites', 
                                    wage:'10000', level: 'Manager', 
                                    requirements: 'Good with people, proactive, must have previous experience on the job, available for travel', 
                                    quantity: 1, date:'31/12/2049', status: 'active', company: company_itc)
        
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company_itc, role: 'Coordenadora RH', admin: true)

        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        candidate_jobs = CandidateJob.create!(candidate: candidate, job: job_itc, message:'', status:'pending', wage:'', beginning_date:'')

        candidate_jobs_rejected = CandidateJob.create!(candidate: candidate, job: rejected_job_itc, message:'Sorry to inform, but you do not meet the requirements we desire for this job, but we will keep you posted for other oportunities that fit your profile.', status:'rejected', wage:'', beginning_date:'')

        login_as candidate
        visit root_path
        click_on 'Acompanhar-candidaturas'

        expect(page).to have_content('IT Manager')
        expect(page).to have_content('rejected')
        expect(page).to have_content('IT support')
        expect(page).to have_content('pending')
    end

    # TODO Flash message is not ideal, change to errors.full_message
    scenario 'and inactive jobs cannot be apllied' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)


    
        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        
        
        login_as candidate
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Candidatar-se'

        expect(current_path).to eq job_path(job_itc)
        expect(page).to have_content('Cannot apply for job')
    end

    scenario 'and track application status' do


        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company_itc, role: 'Coordenadora RH', admin: true)

        prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        rejected_job_itc = Job.create!(title: 'IT Manager', description:'Will be responsible for the infrastructure team on the deployment of new sites', 
                                    wage:'10000', level: 'Manager', 
                                    requirements: 'Good with people, proactive, must have previous experience on the job, available for travel', 
                                    quantity: 1, date:'31/12/2049', status: 'active', company: company_itc)
        
        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms', status:'prop_send', wage:'2000', beginning_date:'31/12/2021')
        

        rejected_candidate_jobs = CandidateJob.create!(candidate: candidate, job: rejected_job_itc, status:'rejected', wage:'', beginning_date:'')
        Message.create!(candidate_job: rejected_candidate_jobs, sender: 'employee', employee: employee, sent_message:'Sorry to inform, but you do not meet the requirements we desire for this job, but we will keep you posted for other oportunities that fit your profile.')

        login_as candidate
        visit root_path
        click_on 'Acompanhar-candidaturas'
        click_on 'IT Manager'

        expect(current_path).to eq job_applied_candidate_job_path(candidate, rejected_job_itc)
        expect(page).to have_content('IT Manager')
        expect(page).to have_content('Will be responsible for the infrastructure team on the deployment of new sites')
        expect(page).to have_content('Good with people, proactive, must have previous experience on the job, available for travel')
        expect(page).to have_content('IT Consulting')
        expect(page).to have_content('rejected')
        expect(page).to have_content('Sorry to inform, but you do not meet the requirements we desire for this job, but we will keep you posted for other oportunities that fit your profile.')


    end

    scenario 'and cannot apply if limit date has passed' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'01/01/2020', status: 'active', company: company_itc)
    
        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', 
                                    first_name: 'Alan', last_name:'Santos', 
                                    cpf: 15612367058, phone:164584652, 
                                    bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        login_as(candidate, :scope => :candidate)
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Candidatar-se'

        expect(current_path).to eq job_path(job_itc)
        expect(page).to have_content('Data limite para aplicação ultrapassou.')
    end
end