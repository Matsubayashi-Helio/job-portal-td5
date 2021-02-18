class CreateCandidateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :candidate_jobs do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.string :message
      t.integer :status
      t.decimal :wage
      t.date :beginning_date

      t.timestamps
    end
  end
end
