require 'rails_helper'

RSpec.describe Attacher::PictureAttach do
  describe 'attachments' do
    let(:artist) { create(:artist) }

    context 'everything works fine' do
      it 'can attach a portrait to an artist if there is a URL' do
        url = 'https://loremflickr.com/300/300/portrait'
        result = Attacher::PictureAttach.new(url, artist.portrait).attach
        expect(result.message).to eq(I18n.t('services.picture_attach.attached'))
        expect(result.created?).to be true
      end
    end

    context 'no portrait url available' do
      it 'will return error message if no url specified' do
        result = Attacher::PictureAttach.new('', artist.portrait).attach
        expect(result.message).to eq(I18n.t('services.picture_attach.no-url'))
        expect(result.created?).to be false
      end
    end

    context 'url present but no valid picture' do
      it 'will return error message if there is no valid picture to attach' do
        result = Attacher::PictureAttach.new('fake_picture_url.jpg', artist.portrait).attach
        expect(result.message).to eq(I18n.t('services.picture_attach.not-found'))
        expect(result.created?).to be false
      end
    end

    context 'no valid model to attach' do
      it 'will return error message if there is no proper field to attach something to' do
        url = 'https://loremflickr.com/300/300/portrait'
        result = Attacher::PictureAttach.new(url, artist.name).attach
        expect(result.message).to eq(I18n.t('services.picture_attach.cannot-attach'))
        expect(result.created?).to be false
      end
    end
  end
end
