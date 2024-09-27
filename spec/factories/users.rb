FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    user_birth_date { Faker::Date.between(from: Date.new(1930, 1, 1), to: Date.today - 5.years) }

    transient do
      last_name_list { %w[山田 すずき タナカ] }
      first_name_list { %w[太郎 じろう サブロウ] }
      last_name_kana_list { %w[ヤマダ スズキ タナカ] }
      first_name_kana_list { %w[タロウ ジロウ サブロウ] }
    end

    last_name { last_name_list.sample }
    first_name { first_name_list.sample }
    last_name_kana { last_name_kana_list.sample }
    first_name_kana { first_name_kana_list.sample }

    email { Faker::Internet.email }
    password { 'Password123' }
    password_confirmation { password }
  end
end
