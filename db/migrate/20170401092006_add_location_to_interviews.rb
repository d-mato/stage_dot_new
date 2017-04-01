class AddLocationToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :location, :text
  end
end
