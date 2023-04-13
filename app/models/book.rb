# == Schema Information
#
# Table name: books
#
#  id         :bigint           not null, primary key
#  issue      :integer          not null
#  pages      :integer          default(0)
#  published  :integer
#  title      :string           not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_books_on_issue  (issue) UNIQUE
#
class Book < ApplicationRecord
  has_many :book_entries, dependent: :destroy
  has_many :stories, through: :book_entries

  validates :title, presence: true
  validates :issue, presence: true, uniqueness: true
end
