# == Schema Information
#
# Table name: book_entries
#
#  id         :bigint           not null, primary key
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_book_entries_on_book_id               (book_id)
#  index_book_entries_on_book_id_and_position  (book_id,position) UNIQUE
#  index_book_entries_on_book_id_and_story_id  (book_id,story_id) UNIQUE
#  index_book_entries_on_story_id              (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (story_id => stories.id)
#
class BookEntry < ApplicationRecord
  # extends
  # includes
  # constants
  # class methods
  # relationships
  belongs_to :book
  belongs_to :story

  # validations
  validates :book_id, uniqueness: { scope: :story_id }
  validates :book_id, uniqueness: { scope: :position }

  # callbacks
  #  scopes
  # additional config
  # public instance methods
  # protected instance methods
  # private instance methods
end
