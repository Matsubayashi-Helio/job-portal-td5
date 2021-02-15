class AddCompanyReferencesToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :employees, :companies, null: false
  end
end
