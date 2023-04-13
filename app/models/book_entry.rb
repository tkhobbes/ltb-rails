# == Schema Information
#
# Table name: book_entries
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_book_entries_on_book_id   (book_id)
#  index_book_entries_on_story_id  (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (story_id => stories.id)
#
class BookEntry < ApplicationRecord
  belongs_to :book
  belongs_to :story
end
