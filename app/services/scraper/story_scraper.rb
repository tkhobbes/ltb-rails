# scrape Artist Data
module Scraper
  #  scrape artist data
  class StoryScraper < ApplicationScraper
    def initialize(story_id)
      super('story', story_id)
      @story_id = story_id
    end

    # this method returns a hash of the scraped data.
    # Data will be nil if nothing found
    def scrape
      return ReturnStory.new(message: I18n.t('services.scraper.no-scraper')) unless @scraper.created?
      return ReturnStory.new(message: I18n.t('services.scraper.no-story')) if story_title.blank?

      story = {
        code: @story_id,
        url: story_url,
        published: story_published,
        origin: story_origin,
        pages: story_pages,
        title: story_title,
        original_title: story_original_title,
        cover_url: story_cover_url
      }
      ReturnStory.new(valid: true, story:, message: @scraper.message)
    end

    private

    # return object
    class ReturnStory
      attr_reader :story, :message

      def initialize(valid: false, story: nil, message: '')
        @valid = valid
        @story = story
        @message = message
      end

      def valid?
        @valid
      end
    end

    def story_title
      (@scraper.data.css('.subHeader span').text.presence || @scraper.data.css('.topHeader h1').text)
    end

    def story_original_title
      @scraper.data.css('.topHeader h1')&.text
    end

    def story_url
      @scraper.data.css('.itemNavigation')&.css('li')&.last&.css('a')&.first&.[]('href')
    end

    def story_published
      dt_node = @scraper.data.xpath('//dt[contains(text(), "Date of first publication")]')
      date_string = dt_node.css('+dd')&.text if dt_node.present?
      date_string.split.last.to_i if date_string.present?
    end

    def story_origin
      dt_node = @scraper.data.xpath('//dt[contains(text(), "Origin")]')
      country_string = dt_node.css('+dd')&.text if dt_node.present?
      ISO3166::Country.find_country_by_iso_short_name(country_string)&.alpha2
    end

    def story_pages
      dt_node = @scraper.data.xpath('//dt[contains(text(), "Pages")]')
      pages_text = dt_node.css('+dd')&.text if dt_node.present?
      pages_text.to_i if pages_text.present?
    end

    def story_cover_url
      img_url = @scraper.data.css('.scan')&.first&.css('figure')&.css('img')&.first&.[]('src')
      "https://inducks.org/#{img_url}" if img_url.present?
    end
  end
end
