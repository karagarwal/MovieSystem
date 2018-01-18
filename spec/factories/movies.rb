FactoryGirl.define do
  factory :movie do
    name Faker::Name.name
    rating Faker::Number.between(1, 5)
    duration Faker::Number.between(1, 3)
    language 'Hindi'
    association :theater, factory: :theater, strategy: :create
    association :audi, factory: :audi, strategy: :create
  end
end
