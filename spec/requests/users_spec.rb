require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path }

    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('users/index')).to be_truthy
    end
  end

  describe 'GET #show' do
    before(:example) { get user_path(1) }
    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('users/show')).to be_truthy
    end
  end
end
