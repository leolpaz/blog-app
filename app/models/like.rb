class Like < ApplicationRecord
  belongs_to :user
  belongs_to :posts

  def update_likes_counter
    if post.likes_counter.nil?
      post.likes_counter = 0
    end
    post.likes_counter += 1
    post.save
  end
end
