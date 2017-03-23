class Resume < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true

  has_paper_trail
end
