# all scrapers are in the same module
module Scraper
  # mega-scraper
  class HolisticScraper
    def initialize(code)
      @code = code
    end

    # the key method to put everything together
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def scrape
      # first - check whether the book is already in the database. If so - no need to scrape
      if book_exists(@code)
        ErrorNotification.with(error: I18n.t('holistic_scrapers.book-exists'), code: @code).deliver_later(User.all)
        return
      end
      # 0. Set up an empty artists array - it will contain all artist ids from all stories
      artists = []
      # 1. scrape the book and retrieve it
      book, message = retrieve_book(@code)
      unless book&.id
        ErrorNotification.with(error: message, code: @code).deliver_later(User.all)
        return
        # raise ActiveRecord::Rollback
      end
      # 1.a retrieve the cover for the book
      retrieve_book_cover(book)
      # 2. go through the book_entries and scrape all stories. Store stories in an array
      story_ids = retrieve_story_entries(book)
      story_ids.each do |story_id|
        story = Story.find(story_id)
        # 2.a retrieve the cover for each story
        retrieve_story_cover(story)
        # 3. go through all stories and their roles and scrape corresponding artists; store IDs in an array
        artists << retrieve_roles(story)
      end
      # 4. Attach the portrait for each artist
      artists.flatten.compact.uniq.each do |artist_id|
        artist = Artist.find(artist_id)
        retrieve_artist_portrait(artist)
      end
      BookNotification.with(book:).deliver_later(User.all)
      # return the created book
      book
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    private

    def book_exists(code)
      Book.find_by(code:).present?
    end

    def error_notification
      ErrorNotification.deliver_later(User.all)
    end

    def retrieve_book(code)
      result = Scraper::BookScraper.new(code).scrape
      b = Book.create(result.data) if result.created?
      [b, result.message]
      # book_attributes = Scraper::BookScraper.new(code).scrape.data
      # Book.create(book_attributes)
    end

    def retrieve_book_cover(book)
      return if book.cover_url.blank?

      result = Attacher::PictureAttach.new(book.cover_url, book.cover).attach
      book.update(cover_url: nil) if result.created?
    end

    # rubocop:disable Metrics/AbcSize
    def retrieve_story_entries(book)
      story_ids = []
      story_codes = Scraper::BookStoryScraper.new(book.code).scrape.data
      story_codes.each_with_index do |story_code, index|
        story_id = Story.find_by(code: story_code)&.id ||
                   Story.create(Scraper::StoryScraper.new(story_code).scrape.story).id
        BookEntry.create(book_id: book.id, story_id:, position: index + 1) unless story_id.nil?
        story_ids << story_id
      end
      story_ids
    end
    # rubocop:enable Metrics/AbcSize

    def retrieve_story_cover(story)
      return if story.cover_url.blank?

      story_attach_result = Attacher::PictureAttach.new(story.cover_url, story.cover).attach
      story.update(cover_url: nil) if story_attach_result.created?
    end

    # rubocop:disable Metrics/AbcSize
    def retrieve_roles(story)
      artists = []
      roles = Scraper::RoleScraper.new(story.code).scrape.roles
      roles.each do |task, artist_code|
        artist_id = Artist.find_by(code: artist_code)&.id ||
                    Artist.create(Scraper::ArtistScraper.new(artist_code).scrape.artist).id
        Role.create(story_id: story.id, task:, artist_id:) unless artist_id.nil?
        artists << artist_id
      end
      artists
    end
    # rubocop:enable Metrics/AbcSize

    def retrieve_artist_portrait(artist)
      return if artist.portrait_url.blank?

      artist_attach_result = Attacher::PictureAttach.new(artist.portrait_url, artist.portrait).attach
      artist.update(portrait_url: nil) if artist_attach_result.created?
    end
  end
end
