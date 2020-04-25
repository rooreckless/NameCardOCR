class CardsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def index
    @cards_inUser = Card.includes(:user).where(user_id: current_user.id).order("created_at DESC")
    Card.calc_samelate('test','test2222')
    @cards_inGroup=Card.includes(:group).where(group_id: current_user.group_id).order("created_at DESC")
    if current_user.group != nil
      @groupname=current_user.group.name
    else
      @groupname="未所属"
    end
  end

  def searchnormaltext
    #puts params #=>params[:name],〜params[:email]
    # @cards=Card.where("name like ?", "%#{params[:name]}%")
    # 上は氏名の曖昧検索です。
    # @cards=Card.where("name like ?", "%#{params[:name]}%").where("company like ?", "%#{params[:company]}%")
    # 上の「where名前あいまい.where会社あいまい」あいまいand検索あいまいになります。
    #また、「where名前あいまい.where会社あいまい」の「名前だけ」検索しても大丈夫です
    @cards_inUser=Card.includes(:user).where(user_id: current_user.id).where("name like ?", "%#{params[:name]}%").where("company like ?", "%#{params[:company]}%").where("department like ?", "%#{params[:department]}%").where("address like ?", "%#{params[:address]}%").where("tel like ?", "%#{params[:tel]}%").where("email like ?", "%#{params[:email]}%")
    #グループ内名刺検索については、「ユーザが所属しているグループと、カードのグループが一致」が条件。ただし「名刺にあるグループがnil」と「user_idが現在のユーザと一致しているもの(inUserに含まれるから)」を除去します。
    @cards_inGroup=Card.includes(:group).where(group_id: current_user.group_id).where.not(group_id: nil).where.not(user_id: current_user.id).where("name like ?", "%#{params[:name]}%").where("company like ?", "%#{params[:company]}%").where("department like ?", "%#{params[:department]}%").where("address like ?", "%#{params[:address]}%").where("tel like ?", "%#{params[:tel]}%").where("email like ?", "%#{params[:email]}%")
  end
  def searchcompany
    # このアクションはcards/show内の会社検索ボタンを押されたときの結果です。
    puts"---searchcompany----"
    puts params
    @searchword=params[:searchcompanyname]
    @cards_inUser=Card.includes(:user).where(user_id: current_user.id).where("company like ?", @searchword)
    @cards_inGroup=Card.includes(:group).where(group_id: current_user.group_id).where.not(group_id: nil).where.not(user_id: current_user.id).where("company like ?", @searchword)
    # binding.pry
  end
  def searchajax
    # GoogleCloudAPIからの認識結果と、先頭から何文字を検索用文字とするかを設定してクラスメソッドへ=>cardsのapiresulthash値に対応する値をつくります。
    searchapiresulthash=Card.createApiresulthash(params[:test],70)
    puts "searchapiresulthash=#{searchapiresulthash}"
    logger.info "searchapiresulthash=#{searchapiresulthash}"
    puts "params = #{params[:test]}"
    logger.info "params = #{params[:test]}"
    @cards_inGroup=Card.includes(:group).includes(:user).where(group_id: current_user.group_id).where.not(group_id: nil).where.not(user_id: current_user.id).where(apiresulthash: (searchapiresulthash - 40000)..(searchapiresulthash + 40000)).order("created_at DESC").to_a
    # 上のGroup内重複候補の検索結果(配列化)に対し、apiresulttextの最初の70文字のレーベンシュタイン距離が大きい場合、配列から除去します。
    @cards_inGroup.reject! {|groupcard| Card.calc_samelate(params[:test],groupcard.apiresulttext)}
    puts "@cards_inGroup.length=#{@cards_inGroup.length}"
    logger.info "@cards_inGroup.length=#{@cards_inGroup.length}"
    @cards_inUser=Card.includes(:user).where(user_id: current_user.id).where(apiresulthash: (searchapiresulthash - 40000)..(searchapiresulthash + 40000)).order("created_at DESC").to_a
    @cards_inUser.reject! {|usercard| Card.calc_samelate(params[:test],usercard.apiresulttext)}
    puts "@cards_inUser.length=#{@cards_inUser.length}"
    logger.info "@cards_inUser.length=#{@cards_inUser.length}"
  end
  def createajax
    require 'google/cloud/language' #APIを使う
    require 'net/http'
    require 'json'
    @params2=params[:test]#=>Base64化された画像データ
    
    #ここからはGCPのvisionAPIへのアクセスです。
    url=Rails.application.credentials[:Google][:Cloudvision_api_key]
    #Net::HTTPでAPIへリクエストを発行する
    uri           = URI.parse(url)
    https         = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    #リクエストにパラメーターをセットする
      req                 = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      param               = {
        "requests" =>
        [
          {
            "image" =>
            {
              "content" => @params2 #フォームからあげられた画像をBase64でエンコード化したもの
            },
            "features" =>
            [
              ##認識してもらいたい内容(猫の画像を入れたりとかした場合で有効)
              # {
              #   "type"       => "LABEL_DETECTION"
              # },
              # {
              #   "type"       => "FACE_DETECTION"
              # },
              # {
              #   "type"       => "IMAGE_PROPERTIES"
              # },
              # {
              #   "type"       => "LOGO_DETECTION"
              # }
              # 画像からテキストを取り出してほしいことを指定
              # https://qiita.com/ozeni/items/16b36f65e32c9e06832e
              # https://qiita.com/Hironsan/items/166515acec35658986b2
              # https://qiita.com/Hironsan/items/166515acec35658986b2
              {
                "type"       => "TEXT_DETECTION",
                "maxResults" => 1,
              }
            ]
          }
        ]
      }
      req.body = param.to_json
      res      = https.request(req)
      # res.body
      res.body.force_encoding("UTF-8")
      #名刺画像で、textdetectionだとなぜかASCIIになってしまう文字コードを強引に変換(猫画像をtextdetection抜きでやってたら別に問題なかったが...)
      # http://koexuka.blogspot.com/2010/03/rubyascii-8bit.html
      
      @resbody=res.body
      @hash = JSON.parse(res.body) #=>String型なres.bodyをJSON形式に変えます。
      @hashdescription=@hash["responses"][0]["textAnnotations"][0]["description"]
      # 上の@hashdescriptionがOCRの結果の文字列です。newcameraビューで表示している内容です。

      #----------------------------ここまでが、画像からOCR。下はテキストから構文解析
      # url = Rails.application.credentials[:Google][:NaturalLanguage_api_key]
      # #こちらはGCPのNaturalLanguageAPIの方のキーです。
      
      # #Net::HTTPでAPIへリクエストを発行する
      # uri           = URI.parse(url)
      # https         = Net::HTTP.new(uri.host, uri.port)
      # https.use_ssl = true

      # #リクエストにパラメーターをセットする
      # req                 = Net::HTTP::Post.new(uri.request_uri)
      # req["Content-Type"] = "application/json"
      # text=@hashdescription
      # param               = {
      #   "document": {
      #       "type": "PLAIN_TEXT",
      #       "language": "JA",
      #       "content": text
      #   },
      #   "encodingType": "UTF8"
      # }
      # req.body = param.to_json
      # resNa      = https.request(req)
      # resNa.body.force_encoding("UTF-8")
      # puts "----------"
      # puts resNa.body
      # puts resNa.body.class
      # resNajsoned= JSON.parse(resNa.body)
  end
  def createdata
    params[:apiresulthash] = Card.createApiresulthash(params[:apiresulttext],70)
    @card = Card.new(card_params)
    if @card.save
      redirect_to card_path(@card.id),notice: '名刺データを作成しました。' and return
    else
      redirect_to newcamera_cards_path,allert:'名刺データの作成に失敗しました。' and return
    end
  end
  def show
    @card=Card.find(params[:id])
    @episode=Episode.new
    
    # 下では、名刺1つに対するエピソードを、「ユーザが設定した「いつ」の降順」になるようにしています。(created_at順ではないです。)
    @episodes=Episode.where(card_id: params[:id]).order(when: "DESC")
  end
  def update
    @card=Card.find(params[:id])
    if @card.update(update_params)
      redirect_to card_path(@card.id),notice: '名刺データを更新しました。' and return
    else
      redirect_to card_path(@card.id),allert: '名刺データを更新に失敗しました。' and return
    end
  end
  def destroy
    card=Card.find(params[:id])
    if current_user.id != card.user_id
      redirect_to root_path and return
    end
    if card.destroy
      redirect_to root_path,notice: '名刺データを削除しました。' and return
    else
      redirect_to cards_path,allert: '名刺データの削除に失敗しました。' and return
    end
    
  end
  private
  def card_params 
    params.permit(:name, :company, :department, :address, :tel,:email,:apiresulttext,:apiresulthash).merge(user_id: current_user.id).merge(group_id: current_user.group_id)
    # .merge(group_id: current_user.group_id)の部分でユーザの所属グループidも保存します。
  end
  def update_params 
    params.require(:card).permit(:name, :company, :department, :address, :tel,:email).merge(user_id: current_user.id).merge(group_id: current_user.group_id)
    # .merge(group_id: current_user.group_id)の部分でユーザの現在所属グループid値で更新します。
  end
end
