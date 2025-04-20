# everything for scrapers goes into one module
module Scraper
  # scrape all stories in a book
  class BookStoryScraper < ApplicationScraper
    # initialisation is the same as for book scrapers
    def initialize(book_id)
      super('issue', book_id, browserless: true)
      @book_id = book_id
    end

    def scrape
      story_ids = @scraper.data.css('tr.normal .code .storycode .codeidentifier').map(&:text)
      if story_ids.blank?
        ReturnStories.new(created: false, msg: I18n.t('services.scraper.no-stories'))
      else
        ReturnStories.new(created: true, data: story_ids, msg: I18n.t('services.scraper.success'))
      end
    end

    # return object
    class ReturnStories
      attr_reader :data, :message

      def initialize(created: false, data: nil, msg: '')
        @created = created
        @data = data
        @message = msg
      end

      def created?
        @created
      end
    end
  end
end
