FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { "12345678" }
    description { FFaker::Lorem.paragraph }
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :post do
    #sequence(:name) { |n| "post#{n}" }
    title { FFaker::Book::title }
    content { FFaker::Lorem.paragraph }
    published { [true, false].sample }
    level { 1 }
    # 綁定user
    user
    #categories
  end

  factory :reply do
    comment { FFaker::Lorem.sentence }
    user
  end
end