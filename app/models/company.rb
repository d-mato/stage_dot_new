class Company < ApplicationRecord
  belongs_to :user
  has_many :interviews

  validates :name, presence: true

  def next_interview_start_at
    return unless interviews.scheduled.present?
    interviews.scheduled.first.start_at
  end
end
