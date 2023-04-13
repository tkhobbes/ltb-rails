require 'rails_helper'

RSpec.describe Role do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if artist is nil' do
        role = Role.new(story: create(:story))
        expect(role).not_to be_valid
      end

      it 'is not valid if story is nil' do
        role = Role.new(artist: create(:artist))
        expect(role).not_to be_valid
      end

      it 'is valid if artist and story are given' do
        role = Role.new(story: create(:story), artist: create(:artist))
        expect(role).to be_valid
      end
    end
  end
end
