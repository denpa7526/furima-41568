FactoryBot.define do
  factory :item do
    item_name { Faker::Lorem.sentence }
    item_info { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    shopping_fee_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    delivery_time_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/Sample01.png'), filename: 'Sample01.png')
    end
  end
end
