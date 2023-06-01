require 'rails_helper'

RSpec.describe 'Artists' do
  describe 'authentication' do
    context 'does not need to log in' do
      it 'can access the artist index path' do
        get artists_path
        expect(response).to have_http_status(:success)
      end

      it 'can access the story show path' do
        artist = create(:artist)
        get artist_path(artist)
        expect(response).to have_http_status(:success)
      end
    end

    context 'can perform CRUD actions when logged in' do
      let(:user) { create(:user) }
      let(:artist) { create(:artist) }

      it 'can create a new artist if logged in' do
        sign_in user
        get new_artist_path
        expect(response).to have_http_status(:success)
        post artists_path, params: { artist: { name: 'Test Test' } }
        expect(Artist.last.name).to eq('Test Test')
      end

      it 'can edit an artist if logged in' do
        sign_in user
        get edit_artist_path(artist)
        expect(response).to have_http_status(:success)
        patch artist_path(artist), params: { artist: { name: 'Test Test' } }
        expect(artist.reload.name).to eq('Test Test')
      end

      it 'can delete an artist if logged in' do
        sign_in user
        delete artist_path(artist)
        expect(response).to have_http_status(:redirect)
        expect(Artist.where(id: artist.id).count).to eq(0)
      end
    end

    context 'cannot perform CRUD actions when logged in' do
      let(:artist) { create(:artist) }

      it 'cannot create a new artist if not logged in' do
        get new_artist_path
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot edit an artist if not logged in' do
        get edit_artist_path(artist)
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot delete an if not logged in' do
        delete artist_path(artist)
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
