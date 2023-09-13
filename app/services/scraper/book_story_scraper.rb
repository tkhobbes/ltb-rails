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
      stories = []
      url = "https://inducks.org/issue.php?c=#{@book_id}"
      begin
        BookStories.start_urls(url)
        BookStories.run(driver: :ferrum, process_timeout: 30, xvfb: true) { |s| stories << story_code(s[:url]) }
        if stories.blank?
          ReturnScraper.new(created: false, msg: I18n.t('services.scraper.no-stories'))
        else
          ReturnScraper.new(created: true, data: stories, msg: I18n.t('services.scraper.success'))
        end
      rescue Vessel::Error, Ferrum::Error => e
        ReturnScraper.new(created: false, msg: I18n.t('services.scraper.httperror', error: e))
      end
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
