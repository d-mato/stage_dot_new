FactoryGirl.define do
  factory :resume do
    user
    body { Faker::Lorem.paragraph }
  end
end
