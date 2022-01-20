class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than: 0 } 
  validates :likes_counter, numericality: { greater_than: 0 } 
  belongs_to :user
  has_many :likes
  has_many :comments

  def update_post_counter
    user.posts_counter = 0 if user.posts_counter.nil?
    user.posts_counter += 1
    user.save
  end

  def recently_commented
    comments.order(created_at: :desc).limit(5)
  end
end
