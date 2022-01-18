class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    post.likes_counter = 0 if post.likes_counter.nil?
    post.likes_counter += 1
    post.save
  end
end
