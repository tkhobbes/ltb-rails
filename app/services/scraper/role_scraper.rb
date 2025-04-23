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
      roles = {}
      Role.tasks.each_key do |task|
        code = artist_code(one_role(task))
        next if code == '%3F' # do not include artists with code "Question Mark"

        roles[task] = code if one_role(task).present?
      end
      return ReturnRoles.new(message: I18n.t('services.scraper.no-scraper')) unless @scraper.created?
      return ReturnRoles.new(message: I18n.t('services.scraper.no-roles')) if roles.blank?

      ReturnRoles.new(valid: true, roles:, message: @scraper.message)
    end

    private

    # Return object with Roles data
    class ReturnRoles
      attr_reader :roles, :message

      def initialize(valid: false, roles: {}, message: '')
        @valid = valid
        @roles = roles
        @message = message
      end

      def valid?
        @valid
      end
    end

    # scrape artist link (url) for a role
    def one_role(role_type)
      dt_node = @scraper.data.xpath("//dt[contains(text(), '#{role_type.humanize}')]")
      dt_node.css('+dd').css('a')&.first&.[]('href') if dt_node.present?
    end

    # return the artist code from a string like https://inducks.org/creator.php?c=RSc
    def artist_code(url)
      url.sub(/^.*c=/, '') if url.present?
    end
  end
end
