# all (external) Searches are in the same module
module Searcher
  # retrieves a list of issues from INDUCKS
  class BookSearchScraper
    def initialize(publication, issue)
      norm_publication = publication.tr(' ', '+')
      @request_uri = nil
      page = "https://inducks.org/compmag.php?title1=#{norm_publication}&entrycodeh3=#{issue}"
      @page_data = scrape_data(page)
    end

    def search_results
      # we might have
      # many results - then return a list of them
      # one result - then return a list of one
      # no result - then return an empty array
      many_results.presence || single_result.presence || []
    end

    private

    # this is the method that can fetch results from a page
    def many_results
      results = []
      if @page_data.css('main.issue').blank?
        @page_data.css('.code').each do |result|
          publication = result.css('.name').first.css('a')
          title = publication.text
          subtitle = result.css('+.name i').text
          code = get_code(publication&.first&.[]('href'))
          results << { title:, subtitle:, code: }
        end
      end
      results
    end

    def single_result
      results = []
      if @page_data.css('main.issue').present?
        publication = @page_data.xpath('//dt[contains(text(), "Publication")]').css('+dd').text
        issue = @request_uri[-7..-1]
        title = "#{publication} #{issue}"
        subtitle = nil
        code = get_code(@request_uri)
        results << { title:, subtitle:, code: }
      end
      results
    end

    # nokogiri-based scraping
    def scrape_data(page)
      url = URI::DEFAULT_PARSER.escape(page)
      raw_html = HTTParty.get(url)
      # store the url in case of redirect
      @request_uri = raw_html.request.last_uri.to_s
      Nokogiri::HTML(raw_html.body)
    end

    def get_code(url)
      url.sub(/^.*c=/, '')
    end
  end
end
