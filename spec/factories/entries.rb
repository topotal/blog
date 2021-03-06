FactoryGirl.define do
  factory :entry do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    eye_catch_image_url { "/assets/img/dummy_eye_catch.png" }
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    updated_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    publish_date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    published { Faker::Boolean.boolean(0.9) }

    trait :with_user do
      user
    end
  end
end
