# scrape roles for a story

module Scraper
  # scrape data
  class RoleScraper < ApplicationScraper
    # initialisation is same as story scraper as we need access to the story page
    def initialize(story_id)
      super('story', story_id)
      @story_id = story_id
    end

    # iterate through all different tasks (enum in Role model) and get artist code
    # for each role present
    def scrape
      result = {}
      Role.tasks.each_key do |task|
        result[task] = artist_code(one_role(task)) if one_role(task).present?
      end
      result
    end

    private

    # scrape artist link (url) for a role
    def one_role(role_type)
      dt_node = @page_data.xpath("//dt[contains(text(), '#{role_type.humanize}')]")
      dt_node.css('+dd').css('a')&.first&.[]('href') if dt_node.present?
    end

    # return the artist code from a string like https://inducks.org/creator.php?c=RSc
    def artist_code(url)
      url.sub(/^.*c=/, '')
    end
  end
end
