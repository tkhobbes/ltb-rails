# renders an entry in a list of artists
class ArtistListComponent < ViewComponent::Base
  def initialize(artist:)
    @artist = artist
    super
  end

  def media_image
    if @artist.portrait.attached?
      image_tag @artist.portrait
    else
      inline_svg_tag('person.svg')
    end
  end

  def life_dates
    [year_born, year_died].compact.join(' | ')
  end

  private

  def year_born
    "#{Artist.human_attribute_name(:born)} #{@artist.born}" if @artist.born
  end

  def year_died
    "#{Artist.human_attribute_name(:died)} #{@artist.died}" if @artist.died
  end
end
