require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before(:each) do
    visit user_session_path
    @test1 = User.create(name: 'Test', photo: 'test_link1', email: 'test@test.com', password: '123456', confirmed_at: Time.now)
    User.create(name: 'Test2', photo: 'test_link2', email: 'test2@test.com', password: '123456', posts_counter: 2, confirmed_at: Time.now)
    User.create(name: 'Test3', photo: 'test_link3', email: 'test3@test.com', password: '123456', posts_counter: 3, confirmed_at: Time.now)
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end
  describe "tests the user index page" do
    it 'can see the username of all other users' do
      expect(page).to have_content 'Test'      
      expect(page).to have_content 'Test2'      
      expect(page).to have_content 'Test3'      
    end
    it 'can see the picture of all other users' do
      imgs = page.all('img')
      expect(page.find(:xpath, "/html/body/ul/li[1]/img")['src']).to have_content 'test_link1'
      expect(page.find(:xpath, "/html/body/ul/li[2]/img")['src']).to eql 'test_link2'
      expect(page.find(:xpath, "/html/body/ul/li[3]/img")['src']).to eql 'test_link3'
    end
    it 'can see the number of posts each user has written' do
      expect(page.find(:xpath, "/html/body/ul/li[1]/span")).to have_content 'Number of posts: 0'
      expect(page.find(:xpath, "/html/body/ul/li[2]/span")).to have_content 'Number of posts: 2'
      expect(page.find(:xpath, "/html/body/ul/li[3]/span")).to have_content 'Number of posts: 3'
    end
    it 'redirects you to the user show page that you clicked' do
      click_link 'Test'
      expect(page).to have_current_path(user_path(@test1.id))
    end
  end
end
