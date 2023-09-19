FactoryBot.define do
  factory :notification do
    recipient factory: %i[user]
    type { 'book' }
    params factory: %i[book]
    read_at { '2023-09-14 14:29:29' }
  end
end
