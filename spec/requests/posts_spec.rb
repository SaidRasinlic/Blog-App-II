require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) { get user_posts_path(1) }

    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('posts/index')).to be_truthy
    end
  end

  describe 'GET #show' do
    before(:example) { get user_post_path(1, 1) }
    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('posts/show')).to be_truthy
    end
  end
end
