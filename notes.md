# Project Management App

## Project
  - belongs_to :user
  - has_many :comments
  - has_many :users, through: :comments
  - belongs_to :category
  
  - title
  - content

## User
  - has_many :posts
  - has_many :comments
  - has_many :commented_posts, through: :comments

  - username
  - email
  - password (password_digest in DB only)

## Comment
  * Join table, joining users and posts
  - belongs_to :user
  - belongs_to :post

  - content

# Wishlist - If time allows
## Task

## Category
  - has_many :posts
  - has_many :users, through: :posts

  - name