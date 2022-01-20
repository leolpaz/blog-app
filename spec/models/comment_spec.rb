require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do 
    @u = User.new(name: 'test', posts_counter: 1)
    @p = @u.posts.new(title: 'test', comments_counter: 0, likes_counter: 0)
    @c = @p.comments.new(text: 'test1', user_id: @u.id)
  end
  it 'updates the comments counter on posts' do
    @c.update_comments_counter
    expect(@p.comments_counter).to eq 1
  end
end
