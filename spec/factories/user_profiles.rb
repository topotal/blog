FactoryGirl.define do
  factory :user_profile do
    screen_name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    image_id { Faker::Crypto.md5 }
    image_content_type { "image/jpeg" }
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    updated_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }

    trait :with_user do
      user
    end
  end
end
