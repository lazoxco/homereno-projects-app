# Project Management App

## Project
  - belongs_to :user
  - has_many :comments
  - has_many :users, through: :comments
  - belongs_to :category
  
  - title
  - content

## User
  - has_many :project
  - has_many :comments
  - has_many :commented_projects, through: :comments

  - username
  - email
  - password (password_digest in DB only)

## Comment
  * Join table, joining users and projects
  - belongs_to :user
  - belongs_to :project

  - content

# Wishlist - If time allows
## Task

## Category
  - has_many :projects
  - has_many :users, through: :projects

  - name