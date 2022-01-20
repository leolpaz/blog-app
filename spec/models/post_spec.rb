require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @u = User.new(name: 'test', posts_counter: 1)
    @p = @u.posts.new(title: 'test', comments_counter: 0, likes_counter: 0)
  end
  it 'title should be present' do
    expect(@p).to be_valid
    @p.title = nil
    expect(@p).to_not be_valid
    @p.title = 'a' * 251
    expect(@p).to_not be_valid
  end
  it 'comments_counter should be greater or equal than 0' do
    expect(@p).to be_valid
    @p.comments_counter = -1
    expect(@p).to_not be_valid
    @p.comments_counter = nil
    expect(@p).to_not be_valid
    @p.comments_counter = 0
    expect(@p).to be_valid
  end
  it 'likes_counter should be greater or equal than 0' do
    expect(@p).to be_valid
    @p.likes_counter = -1
    expect(@p).to_not be_valid
    @p.likes_counter = nil
    expect(@p).to_not be_valid
    @p.likes_counter = 0
    expect(@p).to be_valid
  end
  it 'updates the post counter' do
    @u.save
    @p.update_post_counter
    expect(@u.posts_counter).to eq 2
  end
  it 'correctly shows the 5 most recent comments' do
    @u.save
    @p.comments.new(text: 'test1', user_id: @u.id)
    @p.comments.new(text: 'test2', user_id: @u.id)
    @p.comments.new(text: 'test3', user_id: @u.id)
    @p.comments.new(text: 'test4', user_id: @u.id)
    @p.comments.new(text: 'test5', user_id: @u.id)
    @p.comments.new(text: 'test6', user_id: @u.id)
    @p.save
    expect(@p.recently_commented[0].text).to eq 'test6'
    expect(@p.recently_commented[1].text).to eq 'test5'
    expect(@p.recently_commented[2].text).to eq 'test4'
    expect(@p.recently_commented[3].text).to eq 'test3'
    expect(@p.recently_commented[4].text).to eq 'test2'
  end
end
