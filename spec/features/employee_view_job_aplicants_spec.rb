require 'rails_helper'

feature 'Employee view job aplicants' do
    scenario 'successfully' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)


    
        candidate_rejected = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', 
                                    last_name:'Santos', cpf: 15612367058, phone:164584652, 
                                    bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        candidate_prop_sent = Candidate.create!(email: 'maria@email.com', password: '123456', first_name: 'Maria', 
                                    last_name:'Silva', cpf: 45596090042, phone:153485648, 
                                    bio:'Atuei por dois anos como analista de suporte.')


        candidate_jobs_rejected = CandidateJob.create!(candidate: candidate_rejected, job: job_itc, 
                                            message:'Sorry, but unfortunately you do not have the required requisits for this job.', 
                                            status:'rejected', wage:'', beginning_date:'')

        candidate_jobs_prop_sent = CandidateJob.create!(candidate: candidate_prop_sent, job: job_itc, 
                                                        message: 'We would like to talk more about your previous experience as a analist.', 
                                                        status: 'prop_send', wage: 2500, beginning_date:'31/12/2021')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', 
                                    last_name:'Silva', company: company_itc, 
                                    role: 'Coordenadora RH', admin: true)

        login_as employee
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Analisar-candidaturas'

        expect(current_path).to eq applicants_job_path(job_itc)
        expect(page).to have_content('Alan')
        expect(page).to have_content('alan@email.com')
        expect(page).to have_content('Procurando oportunidade no mercado e com vontade de aprender.')
        expect(page).to have_content('rejected')
        expect(page).to have_content('Maria')
        expect(page).to have_content('maria@email.com')
        expect(page).to have_content('Atuei por dois anos como analista de suporte.')
        expect(page).to have_content('prop_send')
    end

    scenario 'and view candidate information' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)



        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', 
                                            last_name:'Santos', cpf: 15612367058, phone:164584652, 
                                            bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        
        candidate = CandidateJob.create!(candidate: candidate, job: job_itc, 
                                                    message:'', status:'pending', wage:'', beginning_date:'')

        

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', 
                                    last_name:'Silva', company: company_itc, 
                                    role: 'Coordenadora RH', admin: true)

        login_as employee
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Analisar-candidaturas'
        click_on 'Alan'

        expect(current_path).to eq applicant_job_path(job_itc, candidate)
        expect(page).to have_content('Alan Santos')
        expect(page).to have_content('alan@email.com')
        expect(page).to have_content('Procurando oportunidade no mercado e com vontade de aprender.')
        expect(page).to have_content('pending')
        expect(page).to have_content('164584652')
        expect(page).to have_content('15612367058')
    end

    scenario 'and rejects a aplicant' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)



        candidate_to_be_rejected = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', 
                                            last_name:'Santos', cpf: 15612367058, phone:164584652, 
                                            bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        candidate_prop_sent = Candidate.create!(email: 'maria@email.com', password: '123456', first_name: 'Maria', 
                                            last_name:'Silva', cpf: 45596090042, phone:153485648, 
                                            bio:'Atuei por dois anos como analista de suporte.')


        candidate_jobs_to_be_rejected = CandidateJob.create!(candidate: candidate_to_be_rejected, job: job_itc, 
                                                    message:'', status:'pending', wage:'', beginning_date:'')

        candidate_jobs_prop_sent = CandidateJob.create!(candidate: candidate_prop_sent, job: job_itc, 
                                                        message: 'We would like to talk more about your previous experience as a analist.', 
                                                        status: 'prop_send', wage: 2500, beginning_date:'31/12/2021')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', 
                                    last_name:'Silva', company: company_itc, 
                                    role: 'Coordenadora RH', admin: true)

        login_as employee
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Analisar-candidaturas'
        click_on 'Alan'
        fill_in 'Message', with: 'Sorry to inform, but you do not have the requirements we are looking for at the moment.'
        click_on 'Reject-aplicant'

        expect(current_path).to eq applicants_job_path
        expect(page).to have_content('Alan')
        expect(page).to have_content('alan@email.com')
        expect(page).to have_content('Procurando oportunidade no mercado e com vontade de aprender.')
        expect(page).to have_content('rejected')
    end

    scenario 'and send proposal to the candidate' do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)

        candidate_prop_send = Candidate.create!(email: 'maria@email.com', password: '123456', first_name: 'Maria', 
                                            last_name:'Silva', cpf: 45596090042, phone:153485648, 
                                            bio:'Atuei por dois anos como analista de suporte.')

        candidate_jobs_prop_send = CandidateJob.create!(candidate: candidate_prop_sent, job: job_itc, 
                                                        message: '', status: 'pending', wage:'' , beginning_date:'')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', 
                                    last_name:'Silva', company: company_itc, 
                                    role: 'Coordenadora RH', admin: true)

        login_as employee
        visit root_path
        click_on 'Ver-vagas'
        click_on 'IT support'
        click_on 'Analisar-candidaturas'
        click_on 'Maria'
        fill_in 'Message', with: 'We really liked your profile, and it would be fantastic to have you with us. 
                                As already informed, the wage is around entry level. We are sending the details of the job with this message. 
                                Please confirm if you are ok with these terms'
        fill_in 'Beginning Date', with: '31/12/2021'
        fill_in 'Wage', with: '2000'
        click_on 'Send-proposal'

        expect(current_path).to eq applicants_job_path(job_itc)
        expect(page).to have_content('Maria')
        expect(page).to have_content('maria@email.com')
        expect(page).to have_content('Atuei por dois anos como analista de suporte.')
        expect(page).to have_content('pro-sent')
    end
end