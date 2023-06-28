# all (external) Searches are in the same module
module Searcher
  # retrieves a list of issues from INDUCKS
  class BookSearchScraper
    def initialize(publication, issue)
      page = "https://inducks.org/compmag.php?title1=#{publication}&entrycodeh3=#{issue}"
      @page_data = scrape_data(page)
    end

    def search_results
      results = []
      @page_data.css('.code').each do |result|
        publication = result.css('.name').first.css('a')
        title = publication.text
        subtitle = result.css('+.name i').text
        code = get_code(publication&.first&.[]('href'))
        results << { title:, subtitle:, code: }
      end
      results
    end

    private

    # nokogiri-based scraping
    def scrape_data(page)
      url = URI::DEFAULT_PARSER.escape(page)
      raw_html = HTTParty.get(url)
      Nokogiri::HTML(raw_html.body)
    end

    def get_code(url)
      url.sub(/^.*c=/, '')
    end
  end
end
