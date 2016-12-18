FactoryGirl.define do
  factory :image do
    image_id { Faker::Crypto.md5 }
    image_content_type { "image/jpeg" }
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    updated_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
end
