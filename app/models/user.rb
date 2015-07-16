class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :name, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { minimum: 6 }, on: :create
end
