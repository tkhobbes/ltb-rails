# displays entry in a list of stories
class StoryListComponent < ViewComponent::Base
  def initialize(story:)
    @story = story
    super
  end

  def media_image
    @story.cover.attached? ? image_tag(@story.cover) : inline_svg_tag('story.svg')
  end

  def information_list
    [@story.code, render_origin, render_pages].compact.join(' | ')
  end

  def artists_list
    # rubocop:disable Rails/OutputSafety
    [render_drawing_artist, render_story_artist].compact.join(' | ').html_safe
    # rubocop:enable Rails/OutputSafety
  end

  private

  def render_drawing_artist
    "Drawings: #{link_drawing_artist}" if @story.drawings_role
  end

  def render_story_artist
    "Story: #{link_story_artist}" if @story.story_role
  end

  def link_drawing_artist
    return unless @story.drawings_role

    link_to(
      @story.drawings_role.artist.name,
      artist_path(@story.drawings_role.artist.name)
    )
  end

  def link_story_artist
    return unless @story.story_role

    link_to(
      @story.story_role.artist.name,
      artist_path(@story.story_role.artist.name)
    )
  end

  def render_origin
    ISO3166::Country.new(@story.origin)&.translation(locale) unless @story.origin.nil?
  end

  def render_pages
    "#{@story.pages} #{Story.human_attribute_name(:pages)}" unless @story.pages.nil? || @story.pages.zero?
  end
end
