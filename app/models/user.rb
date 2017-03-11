class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable, :recoverable, :trackable

  has_many :social_profiles, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :interviews, through: :companies
  # 受けた友達リクエスト
  has_many :received_friendships, foreign_key: :friend_id, class_name: 'Friendship'
  # 自身が送った友達リクエスト
  has_many :friendships
  has_many :accepted_friendships, -> { accepted }, class_name: 'Friendship'
  has_many :friends, through: :accepted_friendships, class_name: 'User'
  has_one :resume

  validates :email, uniqueness: true, presence: true

  after_create :create_resume

  # 与えられたSocialProfileからUserを新規作成し、関連付けを行う
  # 作成に失敗したらnilを返す
  def self.create_with_social_profile!(profile)
    user = new(name: profile.nickname || profile.name, email: profile.email)
    user.social_profiles << profile
    user.save ? user : nil
  end

  def friend?(user)
    friends.include? user
  end

  private

  def create_resume
    Resume.create!(user_id: id)
  end
end
