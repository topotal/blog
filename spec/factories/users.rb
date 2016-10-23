FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| Faker::Internet.user_name + "(#{n})" }
    password { Faker::Internet.password }
    user_profile
  end
end
