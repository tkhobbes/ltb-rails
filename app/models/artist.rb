# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  born        :integer
#  died        :integer
#  name        :string           not null
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_artists_on_name  (name) UNIQUE
#
class Artist < ApplicationRecord
  # extends
  # includes
  #  constants
  #  class methods
  # relationships
  has_many :roles, dependent: :destroy
  has_many :stories, through: :roles

  has_one_attached :portrait

  #  validations
  validates :name, presence: true, uniqueness: true

  # callbacks
  #  scopes
  # additional config
  # public instance methods
  # protected instance methods
  # private instance methods
end
