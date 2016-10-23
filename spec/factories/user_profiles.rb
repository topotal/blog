FactoryGirl.define do
  factory :user_profile do
    screen_name { Faker::Name.name }
    image_path { Faker::File.file_name("assets/img/upload", Faker::Crypto.md5) }
    description { Faker::Lorem.sentence }
  end
end
