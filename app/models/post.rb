class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :likes, class_name: "Like", foreign_key: "post_id"
  has_many :comments, class_name: "Comment", foreign_key: "post_id"

  after_initialize :init
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.last(5)
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def init
    self.comments_counter ||= 0 # will set the default value only if it's nil
    self.likes_counter ||= 0
  end
end
