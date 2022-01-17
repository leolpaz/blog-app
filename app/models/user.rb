class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def recently_posted
    posts.order(:title, created_at: :desc).limit(3)
  end
end
