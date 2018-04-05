FactoryBot.define do

  sequence :email do |n|
    "#{n}#{Faker::Internet.email}"
  end

  factory :user do
    email
    password "example"
    confirmed_at Time.now
  end
end