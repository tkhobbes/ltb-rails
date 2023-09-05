# everything for scrapers goes into one module
module Scraper
  # scrape all stories in a book
  # class BookStoryScraper < ApplicationScraper
  class BookStoryScraper
    # initialisation is the same as for book scrapers
    def initialize(book_id)
      # super('issue', book_id)
      @book_id = book_id
      # @driver = setup_selenium
    end

    # iterate through all different stories and get an array of codes
    def scrape
      result = []
      url = "https://inducks.org/issue.php?c=#{@book_id}"
      BookStories.start_urls(url)
      BookStories.run { |s| result << story_code(s[:url]) }
      result

      # @driver.navigate.to @page
      # result = []
      # codes = css_elements(@driver, 'tr.normal .code .storycode .codeidentifier')
      # codes.each do |code|
      #   url = code.find_element(:css, 'a')&.attribute('href')
      #   result << story_code(url) if url.present?
      # end
      # @driver.quit
      # result
    end

    # return class
    class BookStories < Vessel::Cargo
      domain 'inducks.org'

      def parse
        css('tr.normal .code .storycode .codeidentifier').each do |code|
          yield({
            url: code.at_css('a')&.[]('href')
          })
        end
      end

      # return the story code from a string like https://inducks.org/story.php?c=I+TL++303-AP
    end

    def story_code(url)
      url.sub(/^.*c=/, '')
    end
  end
end
