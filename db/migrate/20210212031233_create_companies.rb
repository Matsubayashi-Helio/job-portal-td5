class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :cnpj
      t.string :site
      t.string :social_network
      t.string :about
      t.string :address

      t.timestamps
    end
  end
end
