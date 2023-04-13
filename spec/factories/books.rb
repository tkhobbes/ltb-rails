FactoryBot.define do
  factory :book do
    issue { 2 }
    title { 'Hallo...hier Micky!' }
    published { 1968 }
    pages { 260 }
  end
end
