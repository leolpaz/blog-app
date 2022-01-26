require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  before(:each) do
    visit user_session_path
    @test1 = User.create(name: 'Test', photo: 'test_link1', email: 'test@test.com', password: '123456', posts_counter: 3, bio: 'This is a test bio', confirmed_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 0, title: 'test post 1', text: 'This is test post 1', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 0, title: 'test post 2', text: 'This is test post 2', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 0, title: 'test post 3', text: 'This is test post 3', created_at: Time.now)
    @test1.posts.create(user_id: @test1.id, comments_counter: 0, likes_counter: 0, title: 'test post 4', text: 'This is test post 4', created_at: Time.now)
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'Test'
  end
  describe "tests the user show page" do
    it "can see the user's profile picture" do
      expect(page.find(:xpath, "/html/body/div/img")['src']).to have_content 'test_link1'     
    end
    it "can see the user usernames" do
      expect(page.find(:xpath, "/html/body/div/div/h2")).to have_content 'Test'
    end
    it "can see the number of posts the user has writter" do
      expect(page.find(:xpath, "/html/body/div/div/span")).to have_content 'Number of posts: 3'
    end
    it "can see the user's bio" do
      expect(page.find(:xpath, "/html/body/ul/li[1]/p")).to have_content 'This is a test bio'
    end
    it "can see the user's most recent three posts" do
      expect(page).to have_content 'This is test post 4'
      expect(page).to have_content 'This is test post 3'
      expect(page).to have_content 'This is test post 2'
    end
    it "can see the button that allow viewing of all posts" do
      expect(page).to have_button 'See all posts'
    end
    it 'redirects to the see all posts when button is clicked' do 
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@test1))
    end
  end
end
