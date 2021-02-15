class RemoveForeignKeyCompanyFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :employees, :companies
  end
end
