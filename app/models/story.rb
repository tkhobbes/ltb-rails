# == Schema Information
#
# Table name: stories
#
#  id             :bigint           not null, primary key
#  code           :string           not null
#  cover_url      :string
#  origin         :string
#  original_title :string
#  pages          :integer          default(0)
#  published      :integer
#  title          :string
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_stories_on_code  (code) UNIQUE
#
class Story < ApplicationRecord
  # extends
  # includes
  # constants
  #  class methods
  # relationships
  has_many :roles, dependent: :destroy
  has_many :artists, through: :roles
  has_many :book_entries, dependent: :destroy
  has_many :books, through: :book_entries

  has_one_attached :cover

  #  validations
  validates :code, presence: true, uniqueness: true

  # callbacks
  # scopes
  # additional config
  # public instance methods
  def drawings_role
    Role.find(drawings_role_id) if drawings_role_id
  end

  def story_role
    Role.find(story_role_id) if story_role_id
  end

  # protected instance methods
  # private instance methods
  private

  # if a story has a penciller, an inker and a drawer, we need to know whom to return as "main artist"
  def drawings_role_id
    all_roles = roles.pluck(:task, :id)
    (all_roles.assoc('pencils') || all_roles.assoc('ink') || all_roles.assoc('art'))&.last
  end

  def story_role_id
    all_roles = roles.pluck(:task, :id)
    (all_roles.assoc('plot') || all_roles.assoc('script') || all_roles.assoc('writing'))&.last
  end
end
