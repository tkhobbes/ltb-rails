# displays a card for a book
# Usage: <%= render BookCardComponent.new(book: book) %>
class BookCardComponent < ViewComponent::Base
  def initialize(book:)
    @book = book
    super
  end

  def information_list
    [render_published, render_pages].compact.join(' | ')
  end

  def cover_picture
    if @book.cover.attached?
      tag.figure(class: 'image is-4by3 is-flex is-flex-direction-column') do
        image_tag(@book.cover, alt: @book.title, style: 'flex:1; object-fit: cover')
      end
    else
      tag.figure(class: 'image has-text-centered') do
        inline_svg_tag('book.svg', style: 'height: 16em;')
      end
    end
  end

  private

  def render_published
    "#{Book.human_attribute_name(:published)}: #{@book.published}" if @book.published
  end

  def render_pages
    "#{Book.human_attribute_name(:pages)}: #{@book.pages}" unless @book.pages.nil?
  end
end
