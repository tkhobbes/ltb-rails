require 'rails_helper'

RSpec.describe Story do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if the code is blank' do
        story = Story.new(title: 'abc', published: 1961)
        expect(story).not_to be_valid
      end

      it 'is valid if the code is given' do
        story = Story.new(code: '123')
        expect(story).to be_valid
      end

      it 'cannot have two stories with the same code' do
        s = create(:story)
        story = Story.new(code: s.code)
        expect(story).not_to be_valid
      end
    end
  end

  describe 'model methods' do
    context 'role methods' do
      let(:story) { create(:story) }
      let(:artist) { create(:artist) }
      let(:artist2) { create(:artist, name: 'Test Test', code: 'TTe') }
      let(:artist3) { create(:artist, name: 'Test1 Test1', code: 'TT1') }

      it 'returns the drawings role when we have a pencil task' do
        role = Role.create(story:, artist:, task: 'pencils')
        Role.create(story:, artist: artist2, task: 'ink')
        Role.create(story:, artist: artist3, task: 'art')
        expect(story.drawings_role).to eq(role)
      end

      it 'returns the drawings role when we have a ink task' do
        role = Role.create(story:, artist: artist2, task: 'ink')
        Role.create(story:, artist:, task: 'art')
        expect(story.drawings_role).to eq(role)
      end

      it 'returns the drawings role when we have a drawings task' do
        role = Role.create(story:, artist:, task: 'art')
        expect(story.drawings_role).to eq(role)
      end

      it 'does not return a drawings role if we have neither drawings, ink nor pencil task' do
        Role.create(story:, artist:, task: 'writing')
        Role.create(story:, artist: artist2, task: 'plot')
        expect(story.drawings_role).to be_nil
      end

      it 'returns the story role when we have a plot task' do
        role = Role.create(story:, artist:, task: 'plot')
        Role.create(story:, artist: artist2, task: 'script')
        Role.create(story:, artist: artist3, task: 'writing')
        expect(story.story_role).to eq(role)
      end

      it 'returns the story role when we have a script task' do
        role = Role.create(story:, artist: artist2, task: 'script')
        Role.create(story:, artist:, task: 'writing')
        expect(story.story_role).to eq(role)
      end

      it 'returns the story role when we have a story task' do
        role = Role.create(story:, artist:, task: 'writing')
        expect(story.story_role).to eq(role)
      end

      it 'does not return a story role if we have neither story, script nor plot task' do
        Role.create(story:, artist: artist3, task: 'ink')
        Role.create(story:, artist: artist2, task: 'pencils')
        Role.create(story:, artist:, task: 'art')
        expect(story.story_role).to be_nil
      end
    end
  end
end
