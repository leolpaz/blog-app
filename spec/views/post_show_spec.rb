require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before(:each) do
    visit user_session_path
    @test1 = User.create(name: 'Test', photo: 'test_link1', email: 'test@test.com', password: '123456', posts_counter: 3, bio: 'This is a test bio', confirmed_at: Time.now)
    @test2 = User.create(name: 'Test2', photo: 'test_link2', email: 'test2@test.com', password: '123456', posts_counter: 2, confirmed_at: Time.now)
    @post1 = @test1.posts.create(user_id: @test1.id, comments_counter: 2, likes_counter: 13, title: 'test post 1', text: 'This is test post 1', created_at: Time.now)
    @test1.comments.create(post_id: @post1.id, text: 'This is a test comment', created_at: Time.now)
    @test2.comments.create(post_id: @post1.id, text: 'This is another test comment by another user', created_at: Time.now)
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    click_link 'Test'
    click_link 'See all posts'
    click_link 'test post 1'
  end
  describe "tests the show post page" do
    it "can see the post's title" do
      expect(page).to have_content 'test post 1'
    end
    it "can see the post's author" do
      expect(page.find(:xpath, 'html/body/div/h3')).to have_content 'by Test'
    end
    it "can see how many comments and likes the post has" do
      expect(page).to have_content 'Comments: 2, Likes: 13'
    end
    it "can see the post body" do
      expect(page).to have_content 'This is test post 1'
    end
    it "can see the username and comment of each commentor" do
      expect(page).to have_content 'Test: This is a test comment'
      expect(page).to have_content 'Test2: This is another test comment by another user'
    end
  end
end