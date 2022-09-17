/* Create at least one user by running the following code */
  first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

/* Create at least 4 posts written by one of the users you created by running the following code */
   /* Tom (first_user) 2 comments */ 
   first_post = Post.create(author: first_user, title: 'First Post', text: 'This is my first post')
   second_post = Post.create(author: first_user, title: 'Second Post', text: 'This is my second post')
   
   /* Lilly (second_user) 2 comments */
   third_post = Post.create(author: second_user, title: 'First Post', text: 'First post here, lets go!')
   fourth_post = Post.create(author: second_user, title: 'Second Post', text: 'Second post here, lets go!')

/* Create at least 6 posts comments for one of the posts you created by running the following code */
   Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )
   Comment.create(post: first_post, author: first_user, text: 'Heyy Lilly!' )
   Comment.create(post: second_post, author: second_user, text: 'Keep going Tom...' )

   Comment.create(post: third_post, author: first_user, text: 'Congrats Lilly!' )
   Comment.create(post: third_post, author: second_user, text: 'Thanks Tom!' )
   Comment.create(post: fourth_post, author: first_user, text: 'WoW 2nd? Nice.' )
  