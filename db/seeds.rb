company_itc = Company.create!(name: 'IT Consulting', cnpj: '03363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')

                                # search for ways to add arrays and hashs on the model/db
                                # address: {street: 'Rua dos Santos', number: 84, neighborhood: 'Vila dos Santos', city:'São Paulo', state: 'SP', complement: ''}
                                # social_network: ['facebook.com/itc', 'twitter.com/itc','instagram.com/itc']

company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

company_xcode = Company.create!(name: 'XCode Entertainment', cnpj: '94221637000151', site: 'www.xcode.com', 
                        social_network: 'twitter.com/xcode', 
                        about: 'XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay',
                        address: 'Avenida XCode, 01 - São Paulo-SP, Edifício 0, 1º andar')
                        # address: {street: 'Avenida XCode', number: 01, neighborhood: 'Vila Code', city:'São Paulo', state: 'SP', complement: 'Edifício 0, 1º andar'}
                        # social_network: ['facebook.com/xcode', 'twitter.com/xcode','instagram.com/xcode']
company_xcode.cover.attach(io: File.open(Rails.root.join('public','logo','company-xcode-logo.jfif')), filename: 'company-xcode-logo.jfif')

job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                        wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                        quantity: 2, date:'31/12/2050', status: 'active', company: company_itc)

job_xcode = Job.create!(title: 'Map Designer', description:'Will be responsible to create and modify layouts for the levels for the projects', 
                        wage:'6000', level: 'junior', requirements: 'Self-taught, proactive, creative, must have previous experience on the job', 
                        quantity: 1, date:'31/12/2050', status: 'active', company: company_xcode)