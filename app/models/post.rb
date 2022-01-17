class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments

  def update_post_counter
    if user.posts_counter.nil?
      user.posts_counter = 0
    end
    user.posts_counter += 1
    user.save
  end

  def recently_commented
    comments.order(created_at: :desc).limit(5)
  end
end
