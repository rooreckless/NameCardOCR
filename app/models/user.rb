class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cards,dependent: :destroy
  has_many :episodes,dependent: :destroy
  belongs_to  :group
  # ユーザとカード、エピソードとはそれぞれ1対多関係。かつユーザが消えたら、従属テーブルからもレコードが消えるよう設定。
  validates :nickname ,presence: true
end