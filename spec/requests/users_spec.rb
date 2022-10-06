require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) do
      user = User.create!(name: 'Tom', email: 'tom@gmail.org', password: '123456')
      sign_in user
      user.confirm
      sign_in user
      get users_path
    end

    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('Number of posts:')).to be_truthy
    end
  end

  describe 'GET #show' do
    before(:example) do
      user = User.create!(name: 'Lilly', email: 'lilly@gmail.org', password: '123456')
      sign_in user
      user.confirm
      sign_in user
      get user_path(1)
    end
    it 'works! (returns status 200 OK)' do
      expect(response).to have_http_status(200)
    end

    it "renders 'show' template" do
      expect(response).to render_template('show')
    end

    it 'response body includes correct placeholder text' do
      expect(response.body.include?('Comments:')).to be_truthy
    end
  end
end
