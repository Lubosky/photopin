FactoryGirl.define do
  factory :user do |u|
    sequence(:username) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password  'abcd1234'
    password_confirmation 'abcd1234'
  end
end
