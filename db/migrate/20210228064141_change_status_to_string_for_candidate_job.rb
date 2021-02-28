class ChangeStatusToStringForCandidateJob < ActiveRecord::Migration[6.1]
  def change
    change_column :candidate_jobs, :status, :string
    change_column_default :candidate_jobs, :status, 'Pending'
  end
end
