class Group < ApplicationRecord
  has_secure_password
  has_many :users
  has_many :cards
  # cardとのアソシエーションを追記(ユーザが所属しているグループでのカードを検索するため)
  
  validates :name ,presence: true,uniqueness: true
  validates :password_digest ,presence: true
end
