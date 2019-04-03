

## Problem Statement
Create a Rails Application with Rails 5.0 and above and Mongo database
Your Application consists of three models 
User
Post
Comments

Create login screens using devise
Create post and allow users to create comments on a post

Basically create a live commenting system
When a user posts a comment then the other user has to be able to see the comment without reloading the page

You can use TDD approach to implement the above statement
(RSpec)

## System Setup
  * Clone the repository from 
    ```git clone https://github.com/Satkar/posts_and_comments_blog.git```
    
  * Navigate to the project directory using terminal and rub below command
    ```bin/setup```
    
    This command will do the following tasks
    1. Installs gem dependencies
    2. Executes unit specs
    3. Seeds data to User, Post and Comment Collections
    4. Start the redis server
    5. Starts the rails application on http://localhost:3000
    
## Login Details
  Please refer credentials from [here](https://github.com/Satkar/posts_and_comments_blog/blob/master/lib/tasks/post_comment_details.rake#L16)
    
  

