# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  origin     :string
#  pages      :integer          default(0)
#  published  :date
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Story < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :artists, through: :roles
  has_many :book_entries, dependent: :destroy
  has_many :books, through: :book_entries
end
