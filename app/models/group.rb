class Group < ApplicationRecord
  has_secure_password
  has_many :users
  validates :name ,presence: true
  validates :password_digest ,presence: true
end
