# module for all scrapers
module Scraper
  # scrape book details
  class BookScraper < ApplicationScraper
    def initialize(book_id)
      super('issue', book_id, browserless: true)
      @book_id = book_id
    end

    # scrape book data; returns a hash of the scraped data
    def scrape
      return ReturnBook.new(message: I18n.t('services.scraper.no-scraper')) unless @scraper.created?

      book = {
        code: @book_id,
        url: "https://inducks.org/issue.php?c=#{@book_id}",
        title:,
        publication: publication_name,
        issue: issue_number(title),
        pages:,
        published:,
        cover_url:
      }
      return ReturnBook.new(valid: false, message: I18n.t('services.scraper.no-book')) if book[:title].blank?

      ReturnBook.new(valid: true, book:, message: @scraper.message)
    end

    private

    # return object
    class ReturnBook
      attr_reader :book, :message

      def initialize(valid: false, book: nil, message: '')
        @valid = valid
        @book = book
        @message = message
      end

      def valid?
        @valid
      end
    end

    # individual methods to get datapoints for books

    def title
      temp_title = @scraper.data.css('.topHeader h1')&.text
      temp_title.gsub(/^.*:/, '').strip! if temp_title.present?
    end

    def publication_name
      temp_publication = @scraper.data.xpath('//dt[contains(text(), "Publication")]/following-sibling::dd')&.first&.text
      return if temp_publication.blank?

      temp_publication == 'Lustiges Taschenbuch' ? 'ltb' : temp_publication.tr(' ', '_').downcase!
    end

    def issue_number(title)
      subheader = @scraper.data.css('.subHeader')&.text
      data_to_scrape = (subheader.presence || title) # if subheader is blank, use title
      data_to_scrape.gsub(/^.*#/, '').strip! if data_to_scrape.present?
    end

    def pages
      @scraper.data.xpath('//dt[contains(text(), "Pages")]/following-sibling::dd')&.text&.to_i
    end

    def published
      @scraper.data.xpath('//dt[contains(text(), "Date")]/following-sibling::dd/time/a')&.text&.to_i
    end

    def cover_url
      url = @scraper.data.css('.issueImageHighlight .scan figure img').first&.[]('src')
      return if url.blank?

      "https://inducks.org/#{url}"
    end
  end
end
