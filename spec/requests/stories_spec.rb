require 'rails_helper'

RSpec.describe 'Stories' do
  describe 'authentication' do
    context 'does not need to log in' do
      it 'can access the story index path' do
        get stories_path
        expect(response).to have_http_status(:success)
      end

      it 'can access the story show path' do
        story = create(:story)
        get story_path(story)
        expect(response).to have_http_status(:success)
      end
    end

    context 'can perform CRUD actions when logged in' do
      let(:user) { create(:user) }
      let(:story) { create(:story) }

      it 'can create a new story if logged in' do
        sign_in user
        get new_story_path
        expect(response).to have_http_status(:success)
        post stories_path, params: { story: { code: 'ABC 123', title: 'Test Title' } }
        expect(Story.last.title).to eq('Test Title')
      end

      it 'can edit a story if logged in' do
        sign_in user
        get edit_story_path(story)
        expect(response).to have_http_status(:success)
        patch story_path(story), params: { story: { title: 'Test Title' } }
        expect(story.reload.title).to eq('Test Title')
      end

      it 'can delete a story if logged in' do
        sign_in user
        delete story_path(story)
        expect(response).to have_http_status(:redirect)
        expect(Story.where(id: story.id).count).to eq(0)
      end
    end

    context 'cannot perform CRUD actions when logged in' do
      let(:story) { create(:story) }

      it 'cannot create a new story if not logged in' do
        get new_story_path
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot edit a story if not logged in' do
        get edit_story_path(story)
        expect(response).not_to have_http_status(:success)
      end

      it 'cannot delete a story if not logged in' do
        delete story_path(story)
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
