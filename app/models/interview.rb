class Interview < ApplicationRecord
  CATEGORIES = %w(カジュアル面談 懇親会 面接).freeze

  belongs_to :company
  delegate :user, to: :company

  scope :scheduled, -> { where('start_at > ?', Time.zone.now).order(start_at: :asc) }
  scope :finished, -> { where('start_at < ?', Time.zone.now).order(start_at: :asc) }

  validates :start_at, presence: true

  has_paper_trail

  def google_calendar_url
    title = "#{company.name} #{category}"
    details = ''
    format = '%Y%m%dT%H%M00'
    dates = "#{start_at.strftime(format)}/#{start_at.since(1.hour).strftime(format)}"
    "https://www.google.com/calendar/event?action=TEMPLATE&text=#{URI.escape(title)}&details=#{URI.escape(details)}&location=#{URI.escape(location.to_s)}&dates=#{dates}"
  end

  def copy_location
    if company && company.interviews.last
      self.location = company.interviews.last.location
    end
  end
end
