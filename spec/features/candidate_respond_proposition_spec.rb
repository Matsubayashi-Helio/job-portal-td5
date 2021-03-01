require 'rails_helper'

feature 'Candidate respond to proposition' do
    scenario 'and see company proposition' do


        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')
        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company_itc, role: 'Coordenadora RH', admin: true)

        prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms', status:'prop_send', wage:'2000', beginning_date:'31/12/2021')

        Message.create!(candidate_job: prop_sent_candidate_jobs, sender: 'employee', employee: employee, sent_message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')


        login_as candidate
        visit root_path
        click_on 'Acompanhar-candidaturas'
        click_on 'IT support'

        expect(current_path).to eq job_applied_candidate_job_path(candidate, prop_sent_job_itc)
        expect(page).to have_content('IT support')
        expect(page).to have_content('Will act as a front line man on repairs')
        expect(page).to have_content('Good with people, self-taught, proactive')
        expect(page).to have_content('IT Consulting')
        expect(page).to have_content('prop_send')
        expect(page).to have_content('2000')
        expect(page).to have_content('31/12/2021')
        expect(page).to have_content('We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')
    end

    scenario "and reject company's proposition" do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', first_name: 'Alan', last_name:'Santos', cpf: 15612367058, phone:164584652, bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, status:'prop_send', wage:'2000', beginning_date:'31/12/2021')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', first_name:'Ana', last_name:'Silva', company: company_itc, role: 'Coordenadora RH', admin: true)

        Message.create!(candidate_job: prop_sent_candidate_jobs, sender: 'employee', employee: employee, sent_message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')

        login_as(candidate, :scope => :candidate)
        visit root_path
        click_on 'Acompanhar-candidaturas'
        click_on 'IT support'
        fill_in 'Mensagem', with: 'Really appreciate the return. It saddens me to say, but I will have to decline the offer because of a personal reason'
        select('Rejeitar Proposta', :from => 'Status')
        
        click_on 'Enviar Mensagem'

        message = Message.last
        cj = CandidateJob.last
        expect(Message.count).to eq 2
        expect(current_path).to eq job_applied_candidate_job_path(candidate, prop_sent_job_itc)
        expect(cj.reload.status).to eq 'Proposta Rejeitada'
        expect(page).to have_content('We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')
        expect(message.reload.sender).to eq 'candidate'
        expect(message.reload.sent_message).to eq 'Really appreciate the return. It saddens me to say, but I will have to decline the offer because of a personal reason'
        expect(message.reload.candidate).to eq candidate
        expect(message.reload.employee).to eq nil

    end

    scenario "and confirm beginning date" do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', 
                                    first_name: 'Alan', last_name:'Santos', 
                                    cpf: 15612367058, phone:164584652, 
                                    bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, 
                                                    status:'Proposta Enviada', wage:'2000', 
                                                    beginning_date:'31/12/2021')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', 
                                first_name:'Ana', last_name:'Silva', 
                                company: company_itc, role: 'Coordenadora RH', admin: true)

        Message.create!(candidate_job: prop_sent_candidate_jobs, 
                    sender: 'employee', employee: employee, 
                    sent_message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')

        login_as(candidate, :scope => :candidate)
        visit root_path
        click_on 'Acompanhar-candidaturas'
        click_on 'IT support'
        fill_in 'Mensagem', with: 'Thank you for the oportunity again. This date works perfectly for me!'
        select('Confirmar Data de Início', :from => 'Status')
        
        click_on 'Enviar Mensagem'

        message = Message.last
        cj = CandidateJob.last
        expect(Message.count).to eq 2
        expect(current_path).to eq job_applied_candidate_job_path(candidate, prop_sent_job_itc)
        expect(cj.reload.status).to eq 'Data de Início Confirmada'
        expect(page).to have_content('Thank you for the oportunity again. This date works perfectly for me!')
        expect(message.reload.sender).to eq 'candidate'
        expect(message.reload.sent_message).to eq 'Thank you for the oportunity again. This date works perfectly for me!'
        expect(message.reload.candidate).to eq candidate
        expect(message.reload.employee).to eq nil

    end

    scenario "and reject beginning date" do
        company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                        social_network: 'twitter.com/itc', 
                                        about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                        address: 'Rua dos Santos, 84 - São Paulo-SP')
        company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

        candidate = Candidate.create!(email: 'alan@email.com', password: '123456', 
                                    first_name: 'Alan', last_name:'Santos', 
                                    cpf: 15612367058, phone:164584652, 
                                    bio:'Procurando oportunidade no mercado e com vontade de aprender.')

        prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, 
                                                    status:'Proposta Enviada', wage:'2000', 
                                                    beginning_date:'01/04/2021')

        employee = Employee.create!(email: 'ana@itc.com', password: '123456', 
                                first_name:'Ana', last_name:'Silva', 
                                company: company_itc, role: 'Coordenadora RH', admin: true)

        Message.create!(candidate_job: prop_sent_candidate_jobs, 
                    sender: 'employee', employee: employee, 
                    sent_message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')

        login_as(candidate, :scope => :candidate)
        visit root_path
        click_on 'Acompanhar-candidaturas'
        click_on 'IT support'
        fill_in 'Mensagem', with: 'Thank you for the oportunity again. As for the date, could if be on the next week, just so I can end my relationship with my previous company?'
        fill_in 'Data de Início', with: '08/04/2021'
        select('Rejeitar Data de Início', :from => 'Status')
        
        click_on 'Enviar Mensagem'

        message = Message.last
        cj = CandidateJob.last
        expect(Message.count).to eq 2
        expect(current_path).to eq job_applied_candidate_job_path(candidate, prop_sent_job_itc)
        expect(cj.reload.status).to eq 'Data de Início Rejeitada'
        expect(message.reload.sent_message).to eq 'Thank you for the oportunity again. As for the date, could if be on the next week, just so I can end my relationship with my previous company?'
        expect(cj.reload.beginning_date.to_default_s).to eq '2021-04-08'

    end
end