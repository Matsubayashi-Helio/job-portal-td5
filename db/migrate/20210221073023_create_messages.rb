class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :candidate_job, null: false, foreign_key: true
      t.references :candidate, null: true
      t.references :employee, null: true
      t.integer :sender
      t.string :message

      t.timestamps
    end
  end
end
