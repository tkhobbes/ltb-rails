# scrape Artist Data
module Scraper
  #  scrape artist data
  class ArtistScraper < ApplicationScraper
    def initialize(artist_id)
      super('creator', artist_id)
      @artist_id = artist_id
    end

    # this method returns a hash of the scraped data.
    # Data will be nil if nothing found
    def scrape
      {
        code: @artist_id,
        name: artist_name,
        born: artist_born,
        died: artist_died,
        nationality: artist_nationality,
        portrait_url: artist_portrait_url
      }
    end

    private

    # method must not return nil - we set a default name just in case
    def artist_name
      page_data.css('h1') ? page_data.css('h1').text : 'no name'
    end

    # returns nil if no birth year found
    def artist_born
      year = page_data.css('time').first&.css('a')&.text
      year.to_i if year.present?
    end

    def artist_died
      year = page_data.css('time').last&.css('a')&.text
      year.to_i if year.present? && page_data.css('time').count > 1
    end

    def artist_nationality
      page_data.css('a').find { |link| link['href'].include?('nationality') }&.text
    end

    def artist_portrait_url
      tag = page_data.css('img').find { |img| img['src'].include?('creators') }
      tag['src'] if tag.present?
    end
  end
end
