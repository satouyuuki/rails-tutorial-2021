class User < ApplicationRecord
  has_many :micro_posts
  validates :name, presence: true
  validates :email, presence: true
end
