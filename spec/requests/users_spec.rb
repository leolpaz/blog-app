require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET root' do
    before(:each) do
      @u = User.new(name: 'test', posts_counter: 0)
      @u.save
      get('/')
    end
    it 'Gets an ok http status response' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'includes the right placeholder' do
      expect(response.body).to include('User list')
    end
  end

  describe 'GET /show' do
    before(:each) do
      @u = User.new(name: 'test', posts_counter: 0, id: 1)
      @u.save
      get('/users/1')
    end

    it 'render user details correctly' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    it 'includes the right placeholder' do
      expect(response.body).to include('User details')
    end
  end
end
