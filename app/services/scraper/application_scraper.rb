# module for all scrapers - ensuring they stay unique
module Scraper
  # this is the base application scraper
  # all other scraper objects should inherit from this class unless they use vessel
  class ApplicationScraper
    def initialize(scrape_type, scrape_id)
      @page = "http://inducks.org/#{scrape_type}.php?c=#{scrape_id}"
      @page_data = scrape_data
    end

    private

    # nokogiri-based scraping
    def scrape_data
      url = URI::DEFAULT_PARSER.escape(@page)
      raw_html = HTTParty.get(url)
      Nokogiri::HTML(raw_html.body)
    end
  end
end
