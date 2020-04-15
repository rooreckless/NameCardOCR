class Card < ApplicationRecord
  validates :name, :company , presence: true
  belongs_to :user
  belongs_to :group, optional: true
  # groupとのアソシエーションを追記(ユーザが所属しているグループでのカードを検索するため)ただし、グループ未所属でもcardを登録できるようにするため、外部キーであるgroup_idはoptional:trueとしています。
  has_many :episodes, dependent: :destroy

  def self.createApiresulthash(ocred_str,search_length=70)
  # このクラスメソッドは第1引数のGoogleCloudVisionAPIからの答えの文字列から、第2引数の文字列数分先頭から文字コード値を足し込み、返却します。
    ocred_str.gsub!(/(\r\n?|\n|)/,"").gsub!(" ","").gsub!("　","")
    temp_sum=0
    for i in 0..search_length-1 do
      temp_sum+=ocred_str[i].ord
    end
    return temp_sum
  end
end
