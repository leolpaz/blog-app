class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def update_post_counter
    user.posts_counter = 0 if user.posts_counter.nil?
    user.posts_counter += 1
    user.save
  end

  def recently_commented
    comments.order(created_at: :desc).includes(:user).limit(5)
  end
end
