class CandidateJob < ApplicationRecord
  belongs_to :candidate
  belongs_to :job

  enum status: { pending: 0, prop_send:2, date_confirmed:4, prop_rejected:1, date_rejected:3, rejected:9, accepted: 10}
end
