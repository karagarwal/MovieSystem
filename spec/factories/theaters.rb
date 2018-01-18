FactoryGirl.define do
  factory :theater do
    theater_name Faker::Name.name
    address Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
  end
end
