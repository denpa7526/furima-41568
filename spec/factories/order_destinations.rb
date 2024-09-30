FactoryBot.define do
  factory :order_destination do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    addresses { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: 11) }
  end
end
