class AddColumnsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :employee_count, :integer
    add_column :companies, :engineer_count, :integer
    add_column :companies, :good, :text
    add_column :companies, :bad, :text
  end
end
