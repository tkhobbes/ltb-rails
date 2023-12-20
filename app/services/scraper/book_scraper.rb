# module for all scrapers
module Scraper
  # scrape book details
  class BookScraper
    def initialize(book_id)
      @book_id = book_id
    end

    # method to scraper book data
    # rubocop:disable Metrics/MethodLength
    def scrape
      book = {}
      url = "https://inducks.org/issue.php?c=#{@book_id}"
      begin
        BookAttrs.start_urls(url)
        BookAttrs.run(xvfb: true) { |b| book = b }
        book[:code] = @book_id
        book[:url] = url
        if book[:title].blank?
          ReturnScraper.new(created: false, msg: I18n.t('services.scraper.no-book'))
        else
          ReturnScraper.new(created: true, data: book, msg: I18n.t('services.scraper.success'))
        end
      rescue Vessel::Error, Ferrum::Error => e
        ReturnScraper.new(created: false, msg: I18n.t('services.scraper.httperror', error: e))
      end
    end
    # rubocop:enable Metrics/MethodLength

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

    # vessel scraper class
    class BookAttrs < Vessel::Cargo
      domain 'inducks.org'
      # driver :ferrum, process_timeout: 300

      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/CyclomaticComplexity
      # rubocop:disable Metrics/PerceivedComplexity
      def parse
        css('body').each do |header|
          temp_publication = header.at_xpath('//dt[contains(text(), "Publication")]/following-sibling::dd')&.text
          subheader = header.at_css('.subHeader')&.text
          title = short_title(header.at_css('.topHeader h1')&.text)

          yield({
            title:,
            publication: publication_name(temp_publication),
            issue: issue_number(subheader) || issue_number(title),
            pages: header.at_xpath('//dt[contains(text(), "Pages")]/following-sibling::dd')&.text&.to_i,
            published: header.at_xpath('//dt[contains(text(), "Date")]/following-sibling::dd/time/a')&.text&.to_i,
            cover_url: header.at_css('.issueImageHighlight .scan figure img')&.[]('src')
          })
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/AbcSize

      def short_title(title)
        title.gsub(/^.*:/, '').strip! if title.present?
      end

      def publication_name(publication)
        return if publication.blank?

        publication == 'Lustiges Taschenbuch' ? 'ltb' : publication.tr(' ', '_').downcase!
      end

      def issue_number(subheader)
        subheader.gsub(/^.*#/, '').strip! if subheader.present?
      end
    end
  end
end
