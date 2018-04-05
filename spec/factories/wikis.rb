FactoryBot.define do
  factory :wiki do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph(5, false, 4)
    private false
    user
  end
end
