class Company < ApplicationRecord
  belongs_to :user
  has_many :interviews

  scope :archived, -> { where.not(archived_at: nil) }
  scope :not_archived, -> { where(archived_at: nil) }

  validates :name, presence: true

  def next_interview_start_at
    return unless interviews.scheduled.present?
    interviews.scheduled.first.start_at
  end

  def visit_count
    interviews.finished.size
  end
end
