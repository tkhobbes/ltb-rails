# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  issue       :integer          not null
#  pages       :integer          default(0)
#  publication :integer          default(0), not null
#  published   :integer
#  title       :string           not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
  validates :publication, presence: true

  has_one_attached :cover

  enum publication: {
    ltb: 0,
    micky_maus: 1,
    disney_masters: 2,
    floyd_gottfredson_library: 3,
    ltb_collection: 4,
    ltb_exklusiv: 5,
    ltb_extra: 6,
    ltb_ostern: 7,
    ltb_jubilaeum: 8,
    ltb_spezial: 9
  }

  def long_title
    "#{Book.human_enum_name(:publication, publication)} #{issue} - #{title}"
  end
end
