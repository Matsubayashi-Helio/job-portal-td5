class AddDefaultValueStatusCandidateJob < ActiveRecord::Migration[6.1]
  def change
    change_column_default :candidate_jobs, :status, 0
  end
end
