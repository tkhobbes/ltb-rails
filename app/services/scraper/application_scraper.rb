# module for all scrapers - ensuring they stay unique
module Scraper
  # this is the base application scraper
  # all other scraper objects should inherit from this class unless they use vessel
  class ApplicationScraper
    def initialize(scrape_type, scrape_id, options = {})
      @page = "https://inducks.org/#{scrape_type}.php?c=#{scrape_id}"
      @scraper = if options[:browserless] == true
                   scrape_data(browserless: true)
                 else
                   scrape_data
                 end
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
    # rubocop:disable Metrics/MethodLength
    def scrape_data(browserless: false)
      # url = URI::DEFAULT_PARSER.escape(@page)
      begin
        raw_html = if browserless
                     # browserless_doc(url)
                     browserless_doc(@page)
                   else
                     # HTTParty.get(url)
                     HTTParty.get(@page)
                   end
      rescue HTTParty::Error => e
        return ReturnScraper.new(created: false, msg: I18n.t('services.scraper.httperror', error: e))
      end
      # data = Nokogiri::HTML(raw_html.body)
      data = Nokogiri::HTML(raw_html)
      if data.errors.none? { |e| e.fatal? == true }
        ReturnScraper.new(created: true, data:, msg: I18n.t('services.scraper.success'))
      else
        ReturnScraper.new(created: false, msg: I18n.t('services.scraper.nokogirierror', error: data.errors.join(', ')))
      end
    end
    # rubocop:enable Metrics/MethodLength

    # post request to browserless; takes url and token via environment variables
    def browserless_doc(url)
      HTTParty.post(
        "#{ENV.fetch('BLURL', nil)}/content?token=#{ENV.fetch('BLTOKEN', nil)}&launch={\"stealth\":true}",
        headers: {
          accept: 'text/html',
          'Content-Type': 'application/json'
        },
        body: browserless_body(url)
      )
    end

    # the body we need to send to browserless
    def browserless_body(url)
      JSON.dump({
                  setJavaScriptEnabled: true,
                  url:
                })
    end
  end
end
