FactoryBot.define do
  factory :book_entry do
    book
    story
    position { 1 }
  end
end
