FactoryBot.define do
  factory :user do
    user_name { "testuser" }
    email { "test@test.com" }
    password { "testuser" }
    provider { "facebook" }
    uid { "12345678910" }
  end
end
