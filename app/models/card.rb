class Card < ApplicationRecord
  include Amatch
  ReadCardStrLength = 70
  validates :name, :company , presence: true
  belongs_to :user
  belongs_to :group, optional: true
  # groupとのアソシエーションを追記(ユーザが所属しているグループでのカードを検索するため)ただし、グループ未所属でもcardを登録できるようにするため、外部キーであるgroup_idはoptional:trueとしています。
  has_many :episodes, dependent: :destroy

  def self.createApiresulthash(ocred_str)
  # このクラスメソッドは第1引数のGoogleCloudVisionAPIからの答えの文字列から、第2引数の文字列数分先頭から文字コード値を足し込み、返却します。
    ocred_str.gsub!(/(\r\n?|\n|)/,"").gsub!(" ","").gsub!("　","")
    temp_sum=0
    for i in 0..ReadCardStrLength-1 do
      temp_sum+=ocred_str[i].ord
    end
    return temp_sum
  end

  def self.calc_samelate(basisWord,compairWord)
    require 'amatch'
    # このメソッドは引数の2つの文字のレーベンシュタイン距離を計算し、規定数以上の場合、trueを返します。
    # 比較の基準文字と対象文字を先頭から、定数分まで切り出します。
    top_basisWord=basisWord.slice(0..ReadCardStrLength-1)
    top_compairWord=compairWord.slice(0..ReadCardStrLength-1)
    # レーベンシュタイン距離にて一致度が0.8以下
    # puts "PairDistance.new(top_basisWord).match(top_compairWord) = #{PairDistance.new(top_basisWord).match(top_compairWord)}"
    if PairDistance.new(top_basisWord).match(top_compairWord) < 0.8
      # 一致度が0.8以下の場合、そのtrueを返します。
      return true
    else
      return false
    end
  end
end
