class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, :recoverable, :trackable

  has_many :social_profiles, dependent: :destroy

  validates :email, uniqueness: true

  def self.create_with_social_profile!(profile)
    # 登録済みのEmailの場合ランダムなEmailを生成する
    email = User.find_by(email: profile.email) ? random_email : profile.email

    user = create!(name: profile.nickname, email: email)
    profile.update!(user_id: user.id)
    user
  end
end

def random_email
  "#{SecureRandom.hex}@email.com"
end
