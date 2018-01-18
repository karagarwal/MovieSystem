FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    address Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    payment_mode 'Cash'
  end
end
