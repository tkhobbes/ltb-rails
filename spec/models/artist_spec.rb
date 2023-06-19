require 'rails_helper'

RSpec.describe Artist do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if the name is blank' do
        artist = Artist.new(born: 1927, died: 2005, nationality: 'Italy')
        expect(artist).not_to be_valid
      end

      it 'is valid if the name is given' do
        artist = Artist.new(name: 'Romano Scarpa', code: 'RSc')
        expect(artist).to be_valid
      end

      it 'cannot have two artists with the same name' do
        a = create(:artist)
        artist = Artist.new(code: a.code, name: 'Test Test')
        expect(artist).not_to be_valid
      end
    end
  end
end
