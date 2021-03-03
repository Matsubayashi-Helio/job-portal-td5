company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                            social_network: 'twitter.com/itc', 
                            about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                            address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

inactive_job_itc = Job.create!(title: 'IT Manager', description:'Will be responsible for the infrastructure team on the deployment of new sites', 
                            wage:'10000', level: 'Manager', 
                            requirements: 'Good with people, proactive, must have previous experience on the job, available for travel', 
                            quantity: 1, date:'31/12/2049', status: 'inactive', company: company_itc)

prop_sent_job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                            wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                            quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)




company_xcode = Company.create!(name: 'XCode Entertainment', cnpj: '94221637000151', site: 'www.xcode.com', 
                                social_network: 'twitter.com/xcode', 
                                about: 'XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay',
                                address: 'Avenida XCode, 01 - São Paulo-SP, Edifício 0, 1º andar', email_provider: '@xcode.com')
company_xcode.cover.attach(io: File.open(Rails.root.join('public','logo','company-xcode-logo.jfif')), filename: 'company-xcode-logo.jfif')

job_xcode = Job.create!(title: 'Map Designer', description:'Will be responsible to create and modify layouts for the levels for the projects', 
                        wage:'6000', level: 'junior', requirements: 'Self-taught, proactive, creative, must have previous experience on the job', 
                        quantity: 4, date:'31/12/2050', status: 'active', company: company_xcode)



employee = Employee.create!(email: 'maria@itc.com', password: '123456', first_name:'Maria', 
                            last_name:'Silva', company: company_itc, role: 'Coordenadora RH', admin: true)

candidate = Candidate.create!(email: 'pedro@email.com', password: '123456', first_name: 'Pedro', 
                            last_name:'Santos', cpf: 15612367058, phone:164584652, 
                            bio:'Procurando oportunidade no mercado e com vontade de aprender.')



prop_sent_candidate_jobs = CandidateJob.create!(candidate: candidate, job: prop_sent_job_itc, 
                                                status:'Proposta Enviada', wage:'2000', beginning_date:'31/12/2021')

Message.create!(candidate_job: prop_sent_candidate_jobs, sender: 'employee', employee: employee, 
                sent_message:'We really liked your profile, and it would be fantastic to have you with us. As already informed, the wage is around entry level. We are sending the details of the job with this message. Please confirm if you are ok with these terms')



