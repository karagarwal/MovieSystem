FactoryGirl.define do
  factory :seat_type do
    category 'Silver'
    association :audi, factory: :audi, strategy: :create
  end
end
