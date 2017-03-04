class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, :recoverable, :trackable

  has_many :social_profiles, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :interviews, through: :companies
  has_many :friendships
  has_many :accepted_friendships, -> { accepted }, class_name: 'Friendship'
  has_many :friends, through: :accepted_friendships, class_name: 'User'
  has_one :resume

  validates :email, uniqueness: true

  after_create :create_resume

  def self.create_with_social_profile!(profile)
    # 登録済みのEmailの場合ランダムなEmailを生成する
    email = User.find_by(email: profile.email) ? random_email : profile.email

    user = create!(name: profile.nickname || profile.name, email: email)
    profile.update!(user_id: user.id)
    user
  end

  private

  def create_resume
    Resume.create!(user_id: id)
  end
end

def random_email
  "#{SecureRandom.hex}@email.com"
end
