# module for all scrapers
module Scraper
  # scrape book details
  class BookScraper
    def initialize(book_id)
      super('issue', book_id)
      @book_id = book_id
    end

    # method to scraper book data
    def scrape
      {
        code: @book_id,
        issue: book_issue,
        pages: book_pages,
        publication: book_publication,
        published: book_year,
        title: book_title,
        url: book_url
      }
    end

    private

    def book_title
      ''
    end

    def book_issue
      0
    end

    def book_pages
      0
    end

    def book_publication
      0
    end

    def book_year
      0
    end

    def book_url
      ''
    end
  end
end
