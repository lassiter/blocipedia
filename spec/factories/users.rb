FactoryBot.define do
  factory :user do
    email Faker::Internet.unique.email
    password "example"
    confirmed_at Time.now
  end
end