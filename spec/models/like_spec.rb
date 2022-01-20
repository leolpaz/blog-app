require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do 
    @u = User.new(name: 'test', posts_counter: 1)
    @p = @u.posts.new(title: 'test', comments_counter: 0, likes_counter: 0)
    @l = @p.likes.new(user_id: @u.id)
  end
  it 'updates the likes counter on posts' do
    @l.update_likes_counter
    expect(@p.likes_counter).to eq 1
  end
end
