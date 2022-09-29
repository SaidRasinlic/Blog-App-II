class User < ApplicationRecord
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', foreign_key: 'author_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id'

  after_initialize :init

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.includes(comments: [:author]).order(created_at: :desc).limit(3)
  end

  def init
    self.posts_counter ||= 0 # will set the default value only if it's nil
  end
end
