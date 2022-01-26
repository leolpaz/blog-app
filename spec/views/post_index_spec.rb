require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before(:each) do
    visit user_session_path
    @test1 = User.create(name: 'Test', photo: 'test_link1', email: 'test@test.com', password: '123456',
                         posts_counter: 3, bio: 'This is a test bio', confirmed_at: Time.now)
    @post1 = @test1.posts.create(user_id: @test1.id, comments_counter: 1, likes_counter: 13, title: 'test post 1',
                                 text: 'This is test post 1', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 7, title: 'test post 2',
                        text: 'This is test post 2', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 5, title: 'test post 3',
                        text: 'This is test post 3', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 1, title: 'test post 4',
                        text: 'This is test post 4', created_at: Time.now)
    @test1.comments.create(post_id: @post1.id, text: 'This is a test comment', created_at: Time.now)
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'Test'
    click_link 'See all posts'
  end
  describe 'tests the user posts page' do
    it "can see the user's profile picture" do
      expect(page.find(:xpath, '/html/body/div/img')['src']).to have_content 'test_link1'
    end
    it 'can see the user usernames' do
      expect(page.find(:xpath, '/html/body/div/div/h2')).to have_content 'Test'
    end
    it 'can see the number of posts the user has writter' do
      expect(page.find(:xpath, '/html/body/div/div/span')).to have_content 'Number of posts: 3'
    end
    it "can see a user's post's title" do
      expect(page).to have_content 'test post 1'
      expect(page).to have_content 'test post 2'
      expect(page).to have_content 'test post 3'
      expect(page).to have_content 'test post 4'
    end
    it "can see the post's body" do
      expect(page).to have_content 'This is test post 1'
      expect(page).to have_content 'This is test post 2'
      expect(page).to have_content 'This is test post 3'
      expect(page).to have_content 'This is test post 4'
    end
    it 'can see the first comment on a post' do
      expect(page).to have_content 'This is a test comment'
    end
    it 'can see how many comments and likes a post has' do
      expect(page).to have_content 'Comments: 1, Likes: 13'
      expect(page).to have_content 'Comments: 0, Likes: 7'
      expect(page).to have_content 'Comments: 0, Likes: 5'
      expect(page).to have_content 'Comments: 0, Likes: 1'
    end
    it 'redirects to the post show page when a post is clicked' do
      click_link 'test post 1'
      expect(page).to have_current_path(user_post_path(@post1.user.id, @post1.id))
    end
  end
end
