class Version < PaperTrail::Version
  belongs_to :user, foreign_key: :whodunnit, class_name: 'User'

  scope :of_users, ->(users) { where(whodunnit: users.map(&:id)) }
end
