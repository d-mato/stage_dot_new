class Interview < ApplicationRecord
  belongs_to :company

  scope :scheduled, -> { where('start_at > ?', Time.zone.now).order(start_at: :asc) }
  scope :finished, -> { where('start_at < ?', Time.zone.now).order(start_at: :asc) }

  validates :start_at, presence: true
end
