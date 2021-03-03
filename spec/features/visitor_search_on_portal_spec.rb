require 'rails_helper'

feature 'Visitor search on portal' do
    scenario 'for a job' do
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
        company.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                        wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                        quantity: 2, date:'31/12/2050', status: 'active', company: company)


        visit root_path
        fill_in 'Busca', with: 'IT support'
        click_on 'Pesquisar'

        expect(current_path).to eq search_path
        expect(page).to have_content('IT support')
        expect(page).to have_content('Will act as a front line man on repairs')
        expect(page).to have_content('31/12/2050')
    end

    scenario 'for a company' do
        company = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                social_network: 'twitter.com/itc', 
                                about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
        company.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

        visit root_path
        fill_in 'Busca', with: 'IT Consulting'
        click_on 'Pesquisar'

        expect(page).to have_content('IT Consulting')
        expect(page).to have_content('IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.')
        expect(page).to have_content('www.itc.com')
    end

    scenario 'and does not found anything' do
        visit root_path
        fill_in 'Busca', with: 'XCode'
        click_on 'Pesquisar'

        expect(page).to have_content('Nenhum resultado correspondente a busca "XCode"')
        
        within("h2") do
            expect(page).not_to have_content('Vagas')
            expect(page).not_to have_content('Empresas')
        end
    end
end