FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { Faker::Number.between(from: 170, to: 210)}
    brew_time { Faker::Number.between(from: 3, to: 6) }
  end
end
