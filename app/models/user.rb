class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  before_save :generate_slug

  has_secure_password validations: false
  validates :name, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { minimum: 6 }, on: :create

  def generate_slug
    self.slug = self.name.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end
