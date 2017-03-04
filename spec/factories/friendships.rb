FactoryGirl.define do
  factory :friendship do
    user
    friend { FactoryGirl.create :user }
  end
end
