# purpose: attach something to a model
module Attacher
  # attach a picture to a model
  class PictureAttach
    def initialize(picture_url, attach_field)
      @picture_url = picture_url
      @attach_field = attach_field
    end

    # attach a picture to the model via "attach_field"
    def attach
      return ReturnPicture.new(created: false, msg: I18n.t('services.picture_attach.no-url')) if @picture_url.blank?

      begin
        tempfile = Down.download(@picture_url, extension: 'jpg')
      rescue Down::Error
        return ReturnPicture.new(created: false, msg: I18n.t('services.picture_attach.not-found'))
      end
      picture = @attach_field.attach(io: tempfile, filename: 'picture.jpg')
      ReturnPicture.new(created: true, msg: I18n.t('services.picture_attach.attached'), picture:)
    end
  end

  # return object
  class ReturnPicture
    attr_reader :picture, :message

    # this method smells of :reek:BooleanParameter
    def initialize(created: false, msg: '', picture: nil)
      @created = created
      @message = msg
      @picture = picture
    end

    def created?
      @created
    end
  end
end
