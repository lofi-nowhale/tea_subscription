# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

10.times do
  Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "test_email@test.com",
    address: Faker::Address.full_address
  )
end

subscription_1 = Subscription.create!(title: "Green Tea Bundle", price: 4999, frequency: 30)
subscription_2 = Subscription.create!(title: "Black Tea Bundle", price: 4999, frequency: 60)
subscription_3 = Subscription.create!(title: "Herbal Tea Bundle", price: 3999, frequency: 30)
subscription_4 = Subscription.create!(title: "Oolong Tea Bundle", price: 3999, frequency: 60)

4.times do
  Tea.create!(
    title: Faker::Tea.variety(type: 'Green'), 
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 170, to: 210),
    brew_time: Faker::Number.between(from: 3, to: 6),
    subscription_id: subscription_1.id
  )
end 

4.times do
  Tea.create!(
    title: Faker::Tea.variety(type: 'Black'), 
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 170, to: 210),
    brew_time: Faker::Number.between(from: 3, to: 6),
    subscription_id: subscription_2.id
  )
end 

4.times do
  Tea.create!(
    title: Faker::Tea.variety(type: 'Herbal'), 
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 170, to: 210),
    brew_time: Faker::Number.between(from: 3, to: 6),
    subscription_id: subscription_3.id
  )
end 

4.times do
  Tea.create!(
    title: Faker::Tea.variety(type: 'Oolong'), 
    description: Faker::Coffee.notes,
    temperature: Faker::Number.between(from: 170, to: 210),
    brew_time: Faker::Number.between(from: 3, to: 6),
    subscription_id: subscription_3.id
  )
end 

