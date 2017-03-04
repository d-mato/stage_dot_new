class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :friend_id, presence: true

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :pended, -> { where(accepted_at: nil) }

  def accept!
    now = Time.zone.now
    update(accepted_at: now)
    pair.update(accepted_at: now)
  end

  def pair
    Friendship.find_or_initialize_by(user_id: friend_id, friend_id: id)
  end
end
