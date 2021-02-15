class RemoveNotNullConstraintForCompanyIdOnEmployees < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:employees, :company_id, true)
  end
end
