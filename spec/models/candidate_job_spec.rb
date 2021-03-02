require 'rails_helper'

RSpec.describe CandidateJob, type: :model do
  context 'validation' do
    it 'status by default is set to pending' do
      company_itc = Company.create!(name: 'IT Consulting', cnpj: '13363706000106', site: 'www.itc.com', 
                                    social_network: 'twitter.com/itc', 
                                    about: 'IT Counsulting was created in 1984, as a way to make sure everyone is safe, by placing cameras that watch everything.',
                                    address: 'Rua dos Santos, 84 - São Paulo-SP', email_provider: '@itc.com')
      company_itc.cover.attach(io: File.open(Rails.root.join('public','logo','company_itc_logo.jfif')), filename: 'company_itc_logo.jfif')

      job_itc = Job.create!(title: 'IT support', description:'Will act as a front line man on repairs', 
                          wage:'3000', level: 'junior', requirements: 'Good with people, self-taught, proactive', 
                          quantity: 2, date:'31/12/2050', status: 'inactive', company: company_itc)

      candidate = Candidate.create!(email: 'maria@email.com', password: '123456', first_name: 'Maria', 
                                          last_name:'Silva', cpf: 45596090042, phone:153485648, 
                                          bio:'Atuei por dois anos como analista de suporte.')

      candidate_jobs = CandidateJob.create!(candidate: candidate, job: job_itc, 
                                          message: '', wage:'' , beginning_date:'')

      expect(candidate_jobs.status).to eq 'Pending'
    end
  end

  context 'associations' do
    it {should belong_to(:candidate).class_name('Candidate')}
    it {should belong_to(:job).class_name('Job')}
  end
end
