require 'vessel'

class QuotesToScrapeCom < Vessel::Cargo
  domain 'inducks.org'
  start_urls 'https://inducks.org/issue.php?c=de/LTB%20%20%202'

  def parse
    css('body').each do |header|
      yield({
        # author: quote.at_xpath('span/small').text,
        # text: quote.at_css('span.text').text
        title: header.at_css('.topHeader h1').text,
        subheader: header.at_css('.subHeader').text,
        temp_publication: header.at_xpath('//dt[contains(text(), "Publication")]/following-sibling::dd').text,
        pages: header.at_xpath('//dt[contains(text(), "Pages")]/following-sibling::dd').text,
        published: header.at_xpath('//dt[contains(text(), "Date")]/following-sibling::dd/time/a').text,
        cover_url: header.at_css('.issueImageHighlight .scan figure img').[]('src')
      })
    end
  end
end

book = []
QuotesToScrapeCom.run { |b| book << b }
puts book
