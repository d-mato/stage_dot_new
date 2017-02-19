FactoryGirl.define do
  factory :interview do
    company
    start_at { Time.zone.now }
  end
end
