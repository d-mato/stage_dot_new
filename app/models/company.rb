class Company < ApplicationRecord
  belongs_to :user
  has_many :interviews, dependent: :destroy

  scope :archived, -> { where.not(archived_at: nil) }
  scope :not_archived, -> { where(archived_at: nil) }

  validates :name, presence: true

  has_paper_trail

  def archive!
    update(archived_at: Time.zone.now)
  end

  def restore!
    update(archived_at: nil)
  end

  def next_interview_start_at
    return unless interviews.scheduled.present?
    interviews.scheduled.first.start_at
  end

  def visit_count
    interviews.finished.size
  end
end
