class Contact < ApplicationRecord
  belongs_to :user, required: false
end
