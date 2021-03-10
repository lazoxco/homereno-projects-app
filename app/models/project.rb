class Project < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users, through: :comments

  validates :content, :title, presence: true

  scope :most_comments, -> { joins(:comments).group('projects.id').order('count(projects.id) desc') }
end
