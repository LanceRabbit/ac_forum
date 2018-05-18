FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { "12345678" }
    description { FFaker::Lorem.paragraph }

    factory :user_with_posts do
      transient do
        posts_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end

  factory :category do
    sequence(:name) { |n| "user#{n}" }
  end

  factory :post do |f|
    #sequence(:name) { |n| "post#{n}" }
    f.title { FFaker::Book::title }
    f.content { FFaker::Lorem.paragraph }
    f.published { true }
    f.level { 1 }
    # 綁定user
    user

    trait :with_category do
      after(:create) do |post|
        post.category_ids << create(:category)
      end
    end
  end

  factory :reply do
    comment { FFaker::Lorem.sentence }
    user
  end
end