class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :posts

  def update_comments_counter
    if post.comments_counter.nil?
      post.comments_counter = 0
    end
    post.comments_counter += 1
    post.save
  end
end
