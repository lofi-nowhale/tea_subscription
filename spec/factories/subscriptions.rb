FactoryBot.define do
  factory :subscription do
    title { Faker::Hipster.sentence(word_count: 3) }
    price { Faker::Number.decimal(l_digits: 2) }
    frequency { 30 }
  end
end
