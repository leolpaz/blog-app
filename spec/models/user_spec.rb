require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { @u = User.new(name: 'test', posts_counter: 1) }
  it 'name should be present' do
    expect(@u).to be_valid
    @u.name = nil
    expect(@u).to_not be_valid
  end
  it 'posts_counter should be greater or equal than 0' do
    expect(@u).to be_valid
    @u.posts_counter = -1
    expect(@u).to_not be_valid
    @u.posts_counter = nil
    expect(@u).to_not be_valid
    @u.posts_counter = 0
    expect(@u).to be_valid
  end
  it 'correctly shows the 3 most recent posts' do
    @u.posts.new(title: 'test1', comments_counter: 0, likes_counter: 0)
    @u.save
    @u.posts.new(title: 'test2', comments_counter: 0, likes_counter: 0)
    @u.save
    @u.posts.new(title: 'test3', comments_counter: 0, likes_counter: 0)
    @u.save
    @u.posts.new(title: 'test4', comments_counter: 0, likes_counter: 0)
    @u.save
    expect(@u.recently_posted[0].title).to eq 'test4'
    expect(@u.recently_posted[1].title).to eq 'test3'
    expect(@u.recently_posted[2].title).to eq 'test2'
  end
end
