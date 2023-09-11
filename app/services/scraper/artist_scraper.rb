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
      return ReturnArtist.new(message: I18n.t('.services.scraper.no-scraper')) unless @scraper.created?
      return ReturnArtist.new(message: I18n.t('services.scraper.no-artist')) if artist_name.blank?

      artist = {
        code: @artist_id,
        name: artist_name,
        born: artist_born,
        died: artist_died,
        nationality: artist_nationality,
        portrait_url: artist_portrait_url
      }
      ReturnArtist.new(valid: true, artist:, message: @scraper.message)
    end

    private

    # Return object with Artist data
    class ReturnArtist
      attr_reader :artist, :message

      def initialize(valid: false, artist: nil, message: '')
        @valid = valid
        @artist = artist
        @message = message
      end

      def valid?
        @valid
      end
    end

    # method must not return nil - we set a default name just in case
    def artist_name
      # @page_data.css('h1') ? @page_data.css('h1')&.text : 'no name'
      @scraper.data.css('h1') ? @scraper.data.css('h1')&.text : 'no name'
    end

    # returns nil if no birth year found
    def artist_born
      # year = @page_data.css('time')&.first&.css('a')&.text
      year = @scraper.data.css('time')&.first&.css('a')&.text
      year.to_i if year.present?
    end

    def artist_died
      # year = @page_data.css('time')&.last&.css('a')&.text
      # year.to_i if year.present? && @page_data.css('time').count > 1
      year = @scraper.data.css('time')&.last&.css('a')&.text
      year.to_i if year.present? && @scraper.data.css('time').count > 1
    end

    def artist_nationality
      # country_string = @page_data.css('a').find { |link| link['href'].include?('nationality') }&.text
      country_string = @scraper.data.css('a').find { |link| link['href'].include?('nationality') }&.text
      ISO3166::Country.find_country_by_iso_short_name(country_string)&.alpha2 if country_string.present?
    end

    def artist_portrait_url
      # tag = @page_data.css('img').find { |img| img['src'].include?('creators') }
      tag = @scraper.data.css('img').find { |img| img['src'].include?('creators') }
      tag['src'] if tag.present?
    end
  end
end
