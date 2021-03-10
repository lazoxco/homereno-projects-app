class User < ApplicationRecord
  has_many :projects
  has_many :comments
  has_many :commented_projects, through: :comments, source: :projects
  has_secure_password

  validates :username, :email, presence: true
end
