FactoryGirl.define do
  factory :ticket do
    seat_number Faker::Number.between(1, 100)
    price Faker::Number.decimal(3, 2)
    association :movie, factory: :movie, strategy: :create
    association :audi, factory: :audi, strategy: :create
    association :user, factory: :user, strategy: :create
    association :showtime, factory: :showtime, strategy: :create
    association :seat_type, factory: :seat_type, strategy: :create
  end
end
