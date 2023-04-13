FactoryBot.define do
  factory :user do
    email { 'jdoe@example.com' }
    password { 'password' }
    admin { false }
  end
end
