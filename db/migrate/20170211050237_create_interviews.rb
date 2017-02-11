class CreateInterviews < ActiveRecord::Migration[5.0]
  def change
    create_table :interviews do |t|
      t.references :company, foreign_key: true
      t.string :category
      t.datetime :start_at
      t.text :impression

      t.timestamps
    end
  end
end
