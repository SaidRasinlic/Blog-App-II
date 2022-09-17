class User < ApplicationRecord
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', foreign_key: 'author_id'
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id'

  after_initialize :init

  def recent_posts
    posts.last(3)
  end

  private
  def init
    self.posts_counter ||= 0 # will set the default value only if it's nil
  end
end
