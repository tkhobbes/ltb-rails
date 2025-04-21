# Background job to attach a picture to an entity in the database
class AddPictureJob
  include Sidekiq::Job
  sidekiq_options retry: 3

  def perform(model_name, id, picture_path, picture_attribute)
    return unless picture_path

    model = model_name.constantize.find_by(id:)

    picture_to_attach = Down.download(picture_path)
    model.send(picture_attribute.to_sym).send(:attach, io: picture_to_attach, filename: 'picture.jpg')
  end
end
