require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      @u = User.new(name: 'test', posts_counter: 0, id: 1)
      @u.posts.new(title: 'a', comments_counter: 0, likes_counter: 0, id: 1)
      @u.save
      get('/users/1/posts/')
    end
    it 'Gets an ok http status response' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'includes the right placeholder' do
      expect(response.body).to include('Post list')
    end
  end

  describe 'GET /show' do
    before(:each) do
      @u = User.new(name: 'test', posts_counter: 0, id: 1)
      @u.posts.new(title: 'a', comments_counter: 0, likes_counter: 0, id: 1)
      @u.save
      get('/users/1/posts/1')
    end
    it 'render post details correctly' do
      expect(response).to have_http_status(:ok)
    end
    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    it 'includes the right placeholder' do
      expect(response.body).to include('Posts: more')
    end
  end
end
