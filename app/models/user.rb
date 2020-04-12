class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cards,dependent: :destroy
  has_many :episodes,dependent: :destroy
  # ユーザとカード、エピソードとはそれぞれ1対多関係。かつユーザが消えたら、従属テーブルからもレコードが消えるよう設定。
  belongs_to  :group, optional: true
  # グループともアソシエーションを組みます(ユーザ多対グループ1)でも、1ユーザ作成時に1グループ所属決定している必要はないので、groupはnull可(optional: true)です。
  validates :nickname ,presence: true
end
