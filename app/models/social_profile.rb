class SocialProfile < ApplicationRecord
  belongs_to :user, required: false

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def oauth_data=(auth)
    self.attributes = {
      name: auth['info']['name'],
      nickname: auth['info']['nickname'],
      email: auth['info']['email'],
      image_url: auth['info']['image'],
      raw_info: auth['extra']['raw_info'].to_json
    }
  end
end
