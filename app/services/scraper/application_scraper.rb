# module for all scrapers - ensuring they stay unique
module Scraper
  # this is the base application scraper
  # all other scraper objects should inherit from this class unless they use vessel
  class ApplicationScraper
    def initialize(scrape_type, scrape_id)
      @page = "http://inducks.org/#{scrape_type}.php?c=#{scrape_id}"
      @scraper = scrape_data
      # @page_data = scrape_data
    end

    private

    # return object: the data will be in the data attribute
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

    # nokogiri-based scraping
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def scrape_data
      url = URI::DEFAULT_PARSER.escape(@page)
      begin
        raw_html = HTTParty.get(url)
      rescue HTTParty::Error => e
        return ReturnScraper.new(created: false, msg: I18n.t('services.scraper.httperror', error: e))
      end
      data = Nokogiri::HTML(raw_html.body)
      if data.errors.select { |e| e.fatal? == true }.empty?
        ReturnScraper.new(created: true, data:, msg: I18n.t('services.scraper.success'))
      else
        ReturnScraper.new(created: false, msg: I18n.t('services.scraper.nokogirierror', error: data.errors.join(', ')))
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
