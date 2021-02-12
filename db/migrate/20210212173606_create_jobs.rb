class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.decimal :wage
      t.string :level
      t.string :requirements
      t.integer :quantity
      t.datetime :date
      t.integer :status
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
