require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /index' do
    it 'Should redirect to splash screen if not authenticaded' do
      get categories_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(welcome_path)
    end

    it 'Should redirect to splash screen if not authenticaded with root path' do
      get '/'

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(welcome_path)
    end
  end
end
