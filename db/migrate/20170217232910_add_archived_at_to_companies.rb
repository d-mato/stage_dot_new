class AddArchivedAtToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :archived_at, :datetime
  end
end
