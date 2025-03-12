class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  enum priority: [ :low, :medium, :high ]
  enum status: [ :pending, :in_progress, :completed ]
end
