class Company < ApplicationRecord
  belongs_to :user
  has_many :interviews
end
