# module for all scrapers - ensuring they stay unique
module Scraper
  # this is the base application scraper
  # all other scraper objects should inherit from this class
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

    # selenium-based scraping
    def setup_selenium
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      # options.add_argument('--disable-dev-shm-usage')
      # options.add_argument('--remote-debugging-port=9222')
      Selenium::WebDriver.for(:remote, url: Settings.selenium_path, options:)
    end

    # if using selenium-based scraping, more methods to find elements
    # find the first element matching a css identifier
    def css_element(driver, identifier)
      driver.find_elements(:css, identifier)&.first
    end

    # find all elements matching a css identifier
    def css_elements(driver, identifier)
      driver.find_elements(:css, identifier)
    end

    # find the first element matching an xpath
    def xpath_element(driver, xpath)
      driver.find_elements(:xpath, xpath)&.first
    end
  end
end
