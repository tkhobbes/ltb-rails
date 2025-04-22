# displays entry in a list of books
class BookListComponent < ViewComponent::Base
  def initialize(book:)
    @book = book
    super
  end

  def media_image
    @book.cover.attached? ? image_tag(@book.cover) : inline_svg_tag('book.svg')
  end

  def information_list
    [render_pages].compact.join(' | ')
  end

  private

  def render_pages
    "#{@book.pages} #{Book.human_attribute_name(:pages)}" unless @book.pages.nil? || @book.pages.zero?
  end
end
