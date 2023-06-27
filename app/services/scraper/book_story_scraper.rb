# everything for scrapers goes into one module
module Scraper
  # scrape all stories in a book
  class BookStoryScraper < ApplicationScraper
    # initialisation is the same as for book scrapers
    def initialize(book_id)
      super('issue', book_id)
      @book_id = book_id
      @driver = setup_selenium
    end

    # iterate through all different stories and get an array of codes
    def scrape
      @driver.navigate.to @page
      result = []
      codes = css_elements(@driver, 'tr.normal .code .storycode .codeidentifier')
      codes.each do |code|
        url = code.find_element(:css, 'a').attribute('href')
        result << story_code(url) if url.present?
      end
      @driver.quit
      result
    end

    private

    # return the story code from a string like https://inducks.org/story.php?c=I+TL++303-AP
    def story_code(url)
      url.sub(/^.*c=/, '')
    end
  end
end
