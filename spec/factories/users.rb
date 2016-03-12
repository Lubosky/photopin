FactoryGirl.define do
  factory :user do
    id 1
    username  'test_user'
    email     'test_user@example.com'
    password  'abcd1234'
    password_confirmation 'abcd1234'
  end
end
