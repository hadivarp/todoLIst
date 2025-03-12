class User < ApplicationRecord
  has_secure_password

  has_many :tasks
  has_many :categories

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
end
