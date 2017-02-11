class AddMotivationToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :motivation, :text
  end
end
