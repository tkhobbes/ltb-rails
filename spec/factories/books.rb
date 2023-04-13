FactoryBot.define do
  factory :book do
    issue { 1 }
    title { "MyString" }
    date { "2023-04-13" }
    pages { 1 }
  end
end
