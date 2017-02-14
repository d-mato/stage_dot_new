class AddViaToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :via, :string
  end
end
