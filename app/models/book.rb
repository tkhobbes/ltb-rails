# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  cover_url   :string
#  issue       :string           not null
#  pages       :integer          default(0)
#  publication :integer          default("ltb"), not null
#  published   :integer
#  title       :string           not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_books_on_code  (code) UNIQUE
#
class Book < ApplicationRecord
  # extends
  # includes
  # constants
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

  # class methods
  # relationships
  has_many :book_entries, dependent: :destroy
  has_many :stories, through: :book_entries

  has_one_attached :cover
  # validations
  validates :code, presence: true, uniqueness: true
  validates :title, presence: true
  validates :issue, presence: true
  validates :publication, presence: true

  # callbacks
  # scopes
  # additional config (accepts_nested_attributes_for etc.)
  # public instance methods
  def long_title
    "#{Book.human_enum_name(:publication, publication)} #{issue} - #{title}"
  end

  # protected instance methods
  # private instance methods
end
