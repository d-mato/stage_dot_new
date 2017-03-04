class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :friend_id, presence: true

  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :pended, -> { where(accepted_at: nil) }

  def accpet!
    update(accepted_at: Time.zone.now)
  end
end
