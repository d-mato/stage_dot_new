class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
