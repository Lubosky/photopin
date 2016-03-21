FactoryGirl.define do
  factory :user do
    id 1
    username  'test_user'
    sequence(:email) { |n| "test_user#{n}@example.com" }
    password  'abcd1234'
    password_confirmation 'abcd1234'
  end
end
