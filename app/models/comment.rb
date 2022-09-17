class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :comments_counter

  private

  def comments_counter
    post.increment!(:comments_counter)
  end
end
