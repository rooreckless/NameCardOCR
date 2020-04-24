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

  def self.LLength(basisWord,targetWord)
    require 'text'
    # このメソッドは引数の2つの文字のレーベンシュタイン距離を計算し、規定数以上の場合、trueを返します。
    # ---デバッグ用表示部分
    # puts "----self.Levenshtein----"
    # puts "basisWord-.slice(1..100) = #{basisWord.slice(1..70)}"
    # puts "targetWord.slice(1..100) = #{targetWord.slice(1..70)}"
    # puts "Lditance(0..100)=#{Text::Levenshtein.distance(basisWord.slice(1..70), targetWord.slice(1..70))}"
    if Text::Levenshtein.distance(basisWord.slice(1..70), targetWord.slice(1..70)) > 20
      return true
    else
      return false
    end
  end
end
