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
      {
        code: @story_id,
        url: story_url,
        published: story_published,
        origin: story_origin,
        pages: story_pages,
        title: story_title,
        original_title: story_original_title,
        cover_url: story_cover_url
      }
    end

    private

    def story_title
      page_data.css('.subHeader span').text
    end

    def story_original_title
      page_data.css('.topHeader h1').text
    end

    def story_url
      page_data.css('.itemNavigation').css('li').last.css('a').first['href']
    end

    def story_published
      dt_node = page_data.xpath('//dt[contains(text(), "Date of first publication")]')
      date_string = dt_node.css('+dd').text if dt_node.present?
      date_string.split.last.to_i if date_string.present?
    end

    def story_origin
      dt_node = page_data.xpath('//dt[contains(text(), "Origin")]')
      country_string = dt_node.css('+dd').text if dt_node.present?
      ISO3166::Country.find_country_by_iso_short_name(country_string).alpha2
    end

    def story_pages
      dt_node = page_data.xpath('//dt[contains(text(), "Pages")]')
      pages_text = dt_node.css('+dd').text if dt_node.present?
      pages_text.to_i if pages_text.present?
    end

    def story_cover_url
      img_url = page_data.css('.scan')&.first&.css('figure')&.css('img')&.first&.[]('src')
      "https://inducks.org/#{img_url}" if img_url.present?
    end

    def artist_died
      year = page_data.css('time').last&.css('a')&.text
      year.to_i if year.present? && page_data.css('time').count > 1
    end

    def artist_portrait_url
      tag = page_data.css('img').find { |img| img['src'].include?('creators') }
      tag['src'] if tag.present?
    end
  end
end
