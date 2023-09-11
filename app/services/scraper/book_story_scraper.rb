# everything for scrapers goes into one module
module Scraper
  # scrape all stories in a book
  class BookStoryScraper
    # initialisation is the same as for book scrapers
    def initialize(book_id)
      @book_id = book_id
    end

    # iterate through all different stories and get an array of codes
    def scrape
      result = []
      url = "https://inducks.org/issue.php?c=#{@book_id}"
      begin
        BookStories.start_urls(url)
        BookStories.run { |s| result << story_code(s[:url]) }
        ReturnScraper.new(created: true, data: result, msg: I18n.t('services.scraper.success')).data
      rescue Vessel::Error, Ferrum::Error => e
        ReturnScraper.new(created: false, data: result, msg: I18n.t('services.scraper.httperror', error: e)).data
      end
      result
    end

    # return class
    class ReturnScraper
      attr_reader :data, :message

      # this method smells of :reek:BooleanParameter
      def initialize(created: false, data: nil, msg: '')
        @created = created
        @data = data
        @message = msg
      end

      def created?
        @created
      end
    end

    # vessel parser class
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
