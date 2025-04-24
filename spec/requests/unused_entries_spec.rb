require 'rails_helper'

RSpec.describe 'UnusedEntries' do
  describe 'GET' do
    context 'with allowed models' do
      let!(:artist) { create(:artist) }
      let!(:another_artist) { create(:artist, code: 'CB', name: 'Carl Barks') }
      let!(:story) { create(:story, artists: [artist]) }

      it 'renders the show template' do
        get '/unused_entries/Artist'
        expect(response).to render_template(:show)
      end

      it 'shows an entry that is not used' do
        get '/unused_entries/Artist'
        expect(response.body).to include(another_artist.name)
      end

      it 'does not show an entry that is used' do
        get '/unused_entries/Artist'
        expect(response.body).not_to include(artist.name)
      end
    end

    context 'with disallowed models' do
      it 'redirects to the root path if the model is not allowed' do
        get '/unused_entries/InvalidModel'
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE' do
    context 'with disallowed models' do
      it 'redirects to the root path if the model is not allowed' do
        delete '/unused_entries/InvalidModel'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with allowed models' do
      let!(:artist) { create(:artist) }
      let!(:another_artist) { create(:artist, code: 'CB', name: 'Carl Barks') }
      let!(:story) { create(:story, artists: [artist]) }

      it 'deletes the unused entry' do
        delete '/unused_entries/Artist'
        expect(Artist.find_by(name: another_artist.name)).to be_nil
      end

      it 'does not delete an used entry' do
        delete '/unused_entries/Artist'
        expect(Artist.find_by(name: artist.name)).to be_present
      end
    end
  end
end
