class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  # trackableとomniauthableはOAuth認証のため設定しました。

  has_many :cards,dependent: :destroy
  has_many :episodes,dependent: :destroy
  # ユーザとカード、エピソードとはそれぞれ1対多関係。かつユーザが消えたら、従属テーブルからもレコードが消えるよう設定。
  belongs_to  :group, optional: true
  # グループともアソシエーションを組みます(ユーザ多対グループ1)でも、1ユーザ作成時に1グループ所属決定している必要はないので、groupはnull可(optional: true)です。

  validates :nickname ,presence: true

  protected
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(nickname: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
