class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :description, presence: true
end
