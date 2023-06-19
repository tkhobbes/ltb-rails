require 'rails_helper'

RSpec.describe 'Roles' do
  describe 'authentication' do
    context 'can perform CRUD actions when logged in' do
      let(:user) { create(:user) }
      let(:role) { create(:role) }

      it 'can create a new role if logged in' do
        sign_in user
        post roles_path, params: {
          role: { artist_id: role.artist.id, story_id: role.story.id, task: 'pencil' }
        }, as: :turbo_stream
        expect(Role.last.artist.id).to eq(role.artist.id)
        expect(Role.last.story.id).to eq(role.story.id)
        expect(Role.last.task).to eq('pencil')
      end

      it 'can edit a role if logged in' do
        sign_in user
        patch role_path(role), params: { role: { task: 'ink' } }, as: :turbo_stream
        expect(role.reload.task).to eq('ink')
      end

      it 'can delete a role if logged in' do
        sign_in user
        delete role_path(role), as: :turbo_stream
        expect(Role.where(id: role.id).count).to eq(0)
      end
    end

    context 'cannot perform CRUD actions when logged in' do
      let(:role) { create(:role) }

      it 'cannot create a new role if not logged in' do
        post roles_path, params: {
          role: { artist_id: role.artist.id, story_id: role.story.id, task: 'pencil' }
        }, as: :turbo_stream
        expect(Role.last.task).not_to eq('pencil')
        expect(Role.count).to eq(1)
      end

      it 'cannot edit an role if not logged in' do
        patch role_path(role), params: { role: { task: 'ink' } }, as: :turbo_stream
        expect(role.reload.task).to eq('not_given')
      end

      it 'cannot delete a role if not logged in' do
        delete role_path(role), as: :turbo_stream
        expect(Role.where(id: role.id).count).to eq(1)
      end
    end
  end
end
