FactoryGirl.define do
  factory :audi do
    code Faker::Number.between(1, 10)
    number_of_seats Faker::Number.between(1, 100)
    association :theater, factory: :theater, strategy: :create
  end
end
