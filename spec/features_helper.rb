module FeaturesHelper
  def self.find_mail_to(email)
    ActionMailer::Base.deliveries.find { |mail| mail.to.include?(email) }
  end

  def self.create_and_activate_user(name)
    user = User.create!(
      name:, bio: "Bio of #{name}", photo: "#{name}.jpg", email: "#{name}@gmail.com", password: '123456'
    )
    user.save
    user.skip_confirmation!
    user
  end

  def self.create_posts_for_user(author, count: 1)
    posts = []
    count.times do |i|
      posts << Post.create!(
        author:,
        title: "Post ##{i}",
        text: "This is body of post #{i}",
        comments_counter: 0,
        likes_counter: 0
      )
    end
    posts
  end

  def self.create_comments_for_post_by_user(post, author, count: 1)
    comments = []
    count.times do |i|
      comments << Comment.create!(
        author:,
        post:,
        text: "Comment #{i}"
      )
    end
    comments
  end
end
