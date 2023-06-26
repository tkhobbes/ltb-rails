# module for all scrapers
module Scraper
  # scrape book details
  class BookScraper < ApplicationScraper
    attr_reader :page

    def initialize(book_id)
      super('issue', book_id)
      @book_id = book_id
      @driver = setup_selenium
    end

    # method to scraper book data
    def scrape
      {
        code: @book_id,
        url: book_url
      }.merge(request_page)
    end

    private

    def book_url
      page
    end

    def request_page
      @driver.navigate.to @page
      title = short_title(css_element(@driver, '.topHeader h1')&.text)
      subheader = css_element(@driver, '.subHeader')&.text
      publication = publication_name(subheader)
      issue = issue_number(subheader)
      pages = xpath_element(
        @driver,
        '//dt[contains(text(), "Pages")]/following-sibling::dd'
      )&.text&.to_i
      year = xpath_element(
        @driver,
        '//dt[contains(text(), "Date")]/following-sibling::dd/time/a'
      )&.text&.to_i
      cover_url = book_cover_url(@driver)
      @driver.quit
      { title:, issue:, pages:, publication:, year:, cover_url: }
    end

    def short_title(title)
      title.gsub(/^.*:/, '').strip! if title.present?
    end

    def publication_name(subheader)
      return if subheader.blank?

      pos = subheader.index('#') - 1
      result = subheader[0..pos].strip!
      result == 'Lustiges Taschenbuch' ? 'ltb' : result.tr(' ', '_').downcase!
    end

    def issue_number(subheader)
      subheader.gsub(/^.*#/, '').strip!.to_i if subheader.present?
    end

    def book_cover_url(driver)
      css_element(driver, '.issueImageHighlight .scan figure img')&.[]('src')
      # "https://inducks.org/#{img_url}" if img_url.present?
    end
  end
end
