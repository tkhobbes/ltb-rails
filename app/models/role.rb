# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  task       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :bigint           not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_roles_on_artist_id                        (artist_id)
#  index_roles_on_artist_id_and_story_id_and_task  (artist_id,story_id,task) UNIQUE
#  index_roles_on_story_id                         (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (story_id => stories.id)
#
class Role < ApplicationRecord
  # extends
  # includes
  # constants
  # ENUM for task encaptures the different roles an artist can have for a story
  enum task: {
    not_given: 0,
    drawings: 1,
    pencil: 2,
    ink: 3,
    color: 4,
    lettering: 5,
    story: 6,
    plot: 7,
    script: 8
  }

  # class methods
  # relationships
  belongs_to :artist
  belongs_to :story

  # validations
  validates :task, uniqueness: { scope: %i[artist_id story_id] }

  # callbacks
  # scopes
  #  additional config
  # public instance methods
  # protected instance methods
  # private instance methods
end
