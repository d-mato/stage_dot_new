class Version < PaperTrail::Version
  belongs_to :user, foreign_key: :whodunnit, class_name: 'User'
end
