FactoryBot.define do
  factory :book do
    code { 'de/LTB%20%20%202' }
    issue { 2 }
    title { 'Hallo...hier Micky!' }
    published { 1968 }
    pages { 260 }
  end
end
