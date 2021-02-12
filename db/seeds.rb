company_itc = Company.create!(name: 'IT Consulting', cnpj: '03363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP')

                                # search for ways to add arrays and hashs on the model/db
                                # address: {street: 'Rua dos Santos', number: 84, neighborhood: 'Vila dos Santos', city:'São Paulo', state: 'SP', complement: ''}
                                # social_network: ['facebook.com/itc', 'twitter.com/itc','instagram.com/itc']

company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company itc logo.jfif')), filename: 'company itc logo.jfif')

company_xcode = Company.create!(name: 'XCode Entertainment', cnpj: '94221637000151', site: 'www.xcode.com', 
                        social_network: 'twitter.com/xcode', 
                        about: 'XCode is a game developer studio that focus on VR and AR tecnologies for more immersion in the gameplay',
                        address: 'Avenida XCode, 01 - São Paulo-SP, Edifício 0, 1º andar')
                        # address: {street: 'Avenida XCode', number: 01, neighborhood: 'Vila Code', city:'São Paulo', state: 'SP', complement: 'Edifício 0, 1º andar'}
                        # social_network: ['facebook.com/xcode', 'twitter.com/xcode','instagram.com/xcode']
company_xcode.cover.attach(io: File.open(Rails.root.join('public','logo','company xcode logo.jfif')), filename: 'company xcode logo.jfif')