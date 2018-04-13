# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@timestamp = Faker::Time.between(2.days.ago, Date.today, :all)
@random_boolean = [true, false].sample
# Create Users
5.times do
  
  User.create!(
    email: Faker::Internet.unique.email,
    password: "example",
    role: rand(0..1),
    confirmed_at: DateTime.now,
    sign_in_count: 1,
    created_at: @timestamp,
    updated_at: @timestamp
  )
  User.create!(
    email: Faker::Internet.unique.email,
    password: "example",
    role: rand(0..1),
    confirmed_at: DateTime.now,
    sign_in_count: 1,
    created_at: @timestamp,
    updated_at: @timestamp
  )
end
1.times do
  User.create!(
    email: 'lassitergregg@gmail.com',
    password: 'example',
    role: 2,
    confirmed_at: DateTime.now,
    sign_in_count: 1,
    created_at: @timestamp,
    updated_at: @timestamp
  )
end
# Create Wiki
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(6, false, 6),
    private: @random_boolean,
    user_id: rand(1..(User.count - 1)),
    created_at: @timestamp,
    updated_at: @timestamp
  )
end
# Create Collaborators
30.times do
  Collaborator.create!(
    wiki_id: rand(1..(Wiki.count - 1)),
    user_id: rand(1..(User.count - 1)),
    created_at: @timestamp,
    updated_at: @timestamp
  )
end
5.times do
  Collaborator.create!(
    wiki_id: 1,
    user_id: rand(1..(User.count - 1)),
    created_at: @timestamp,
    updated_at: @timestamp
  )
end

puts "Created #{User.count} users and expect 11 per run"
puts "Created #{Wiki.count} users and expect 50 per run"
puts "Created #{Collaborator.count} collaborators and expect 35 per run"

# Faker Cleanup
1.times do 
  Faker::UniqueGenerator.clear
end