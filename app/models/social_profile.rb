class SocialProfile < ApplicationRecord
  belongs_to :user

  validates :uid, uniqueness: { scope: :provider }

  def oauth_data=(auth)
    self.attributes = {
      name: auth['info']['name'],
      nickname: auth['info']['nickname'],
      email: auth['info']['email'],
      image_url: auth['info']['image'],
      raw_info: auth['extra']['raw_info']
    }
  end
end
