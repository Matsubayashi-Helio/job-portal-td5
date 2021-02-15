class AddEmailProviderToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :email_provider, :string
  end
end
