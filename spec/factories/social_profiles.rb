FactoryGirl.define do
  factory :social_profile do
    email Faker::Internet.email
    nickname Faker::Name.name
    name Faker::Internet.user_name
  end
end
