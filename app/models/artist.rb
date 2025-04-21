# == Schema Information
#
# Table name: artists
#
#  id           :bigint           not null, primary key
#  born         :integer
#  code         :string           not null
#  died         :integer
#  name         :string           not null
#  nationality  :string
#  portrait_url :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_artists_on_code  (code) UNIQUE
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
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  # callbacks
  after_create do
    AddPictureJob.perform_async('Artist', id, portrait_url, 'portrait') if portrait_url.present?
  end

  # scopes
  # additional config
  # public instance methods
  # protected instance methods
  # private instance methods
end
