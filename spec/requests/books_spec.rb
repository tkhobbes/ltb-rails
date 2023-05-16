require 'rails_helper'

RSpec.describe 'Books' do
  describe 'GET /index' do
    it 'returns http success' do
      get books_path
      expect(response).to have_http_status(:success)
    end
  end
end
