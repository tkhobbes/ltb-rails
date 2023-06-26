# module for all scrapers - ensuring they stay unique
module Scraper
  # this is the base application scraper
  # all other scraper objects should inherit from this class
  class ApplicationScraper
    def initialize(scrape_type, scrape_id)
      @page = "http://inducks.org/#{scrape_type}.php?c=#{scrape_id}"
    end

    private

    # nokogiri-based scraping
    def page_data
      url = URI::DEFAULT_PARSER.escape(@page)
      raw_html = HTTParty.get(url)
      Nokogiri::HTML(raw_html.body)
    end

    # selenium-based scraping
    def setup_selenium
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      Selenium::WebDriver.for(:chrome, options:)
    end

    # if using selenium-based scraping, more methods to find elements
    def css_element(driver, identifier)
      driver.find_elements(:css, identifier)&.first
    end

    def xpath_element(driver, xpath)
      driver.find_elements(:xpath, xpath)&.first
    end
  end
end
