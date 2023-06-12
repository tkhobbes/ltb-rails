# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoryListComponent, type: :component do
  describe 'rendering component' do
    context 'attributes' do
      let(:story) { create(:story) }
      let(:story_just_code) { create(:story, code: '123abc', title: 'test', origin: nil, pages: nil) }
      let(:story_just_origin) { create(:story, code: '987xyz', title: 'test2', pages: nil) }
      let(:story_just_pages) { create(:story, code: '456def', title: 'test3', origin: nil) }

      it 'shows code, origin and pages if all are given' do
        render_inline(described_class.new(story:))
        expect(page).to have_content(
          "#{story.code} | #{ISO3166::Country.new(story.origin)&.translation('de')} | #{story.pages} #{Story.human_attribute_name(:pages)}"
        )
      end

      it 'shows only code if origin and pages are not given' do
        render_inline(described_class.new(story: story_just_code))
        expect(page).to have_content('123abc')
        expect(page).not_to have_content(' | ')
      end

      it 'shows only code and origin if pages are not given' do
        render_inline(described_class.new(story: story_just_origin))
        expect(page).to have_content("987xyz | #{ISO3166::Country.new(story_just_origin.origin)&.translation('de')}")
        expect(page).not_to have_content(Story.human_attribute_name(:pages))
      end

      it 'shows only code and pages if origin is not given' do
        render_inline(described_class.new(story: story_just_pages))
        expect(page).to have_content("456def | #{story_just_pages.pages} #{Story.human_attribute_name(:pages)}")
      end
    end

    context 'artists' do
      let(:role) { create(:role, task: 1) } # drawings: 1
      let!(:role2) { create(:role, story: role.story, artist: role.artist, task: 6) } # story: 6
      let(:story2) { create(:story, code: '123abc', title: 'test', origin: nil, pages: nil) }
      let(:story3) { create(:story, code: '987xyz', title: 'test2', origin: nil, pages: nil) }
      let(:role_drawing) { create(:role, artist: role.artist, task: 1, story: story2) }
      let(:role_story) { create(:role, task: 6, story: story3, artist: role.artist) }

      it 'shows both a drawing and a story artist if both are given' do
        render_inline(described_class.new(story: role.story))
        expect(page).to have_content("Drawings: #{role.artist.name} | Story: #{role2.artist.name}")
      end

      it 'does only show drawing artist if no story artist given' do
        render_inline(described_class.new(story: role_drawing.story))
        expect(page).to have_content("Drawings: #{role_drawing.artist.name}")
        expect(page).not_to have_content('Story')
        expect(page).not_to have_content(' | ')
      end

      it 'dos only show story artist if no drawing artist given' do
        render_inline(described_class.new(story: role_story.story))
        expect(page).to have_content("Story: #{role_story.artist.name}")
        expect(page).not_to have_content('Drawings')
        expect(page).not_to have_content(' | ')
      end
    end

    context 'cover images' do
      let(:story) { create(:story) }
      # add test for actual cover image

      it 'shows an svg placeholder if no cover image is attached' do
        render_inline(described_class.new(story:))
        expect(page).to have_css('svg')
      end
    end
  end
end
