class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def admin?
    role == 'admin'
  end

  def recently_posted
    posts.order(created_at: :desc).limit(3)
  end
end
