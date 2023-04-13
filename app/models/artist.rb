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
class Artist < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :stories, through: :roles

  validates :name, presence: true
end
