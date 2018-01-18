FactoryGirl.define do
  factory :showtime do
    timing Faker::Time.between(DateTime.now - 1, DateTime.now)
    association :movie, factory: :movie, strategy: :create
  end
end
