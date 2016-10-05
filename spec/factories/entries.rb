FactoryGirl.define do
  factory :entry do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    eye_catching { Faker::Lorem.sentence }
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    updated_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    publish_date { Faker::Time.between(DateTime.now - 1, DateTime.now) }

    trait :with_user do
      user
    end
  end
end
