class CardsController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def top

  end
  def index
    @cards = Card.includes(:user).where(user_id: current_user.id).order("created_at DESC")
    puts @cards
    puts @cards.length
  end
  def searchnormalform

  end
  def searchnormaltext
    #puts params #=>params[:name],〜params[:email]
    # @cards=Card.where("name like ?", "%#{params[:name]}%")
    # 上は氏名の曖昧検索です。
    # @cards=Card.where("name like ?", "%#{params[:name]}%").where("company like ?", "%#{params[:company]}%")
    # 上の「where名前あいまい.where会社あいまい」あいまいand検索あいまいになります。
    #また、「where名前あいまい.where会社あいまい」の「名前だけ」検索しても大丈夫です。
    @cards=Card.where("name like ?", "%#{params[:name]}%").where("company like ?", "%#{params[:company]}%").where("department like ?", "%#{params[:department]}%").where("address like ?", "%#{params[:address]}%").where("tel like ?", "%#{params[:tel]}%").where("email like ?", "%#{params[:email]}%")
    puts "-----searchnormaltext----"
    puts @cards
    puts @cards.length
    # binding.pry
    
  end
  def searchcamera
    puts "----searchcamera----"
    puts params
  end
  def searchajax
    puts "----searchAJAX----"
    puts params
    # 検索対象の文字列はparams[:test]です。ただし"\n"が含まれているので、検索前に除去が必要です。createdataアクションとの統一感のため空白文字(全角半角ともに)も除去します。
    params[:test].gsub!(/(\r\n?|\n|)/,"")
    params[:test].gsub!(" ","")
    params[:test].gsub!("　","")
    puts "----searchAJAX gsub!----"
    puts params
    
    temp_sum=0
    for i in 0..69 do
      # デバッグ用表示
      # puts "i=#{i}, #{params[:test][i]}, params[:test][i].ord = #{params[:test][i].ord}"
      temp_sum+=params[:test][i].ord
    end
    # temp_sumは検索用の文字列の先頭から70文字の文字コードを足しこんだものです。これの+-20000の範囲で、cardモデルのapiresulthash値で検索して@cardsとします。
    # 現状はログインユーザと、そのカードを登録したユーザが一致していることも条件に含め増す。
    @cards=Card.where(apiresulthash: (temp_sum - 20000)..(temp_sum + 20000)).where(user_id: current_user.id)
  end
  def createajax
    require 'google/cloud/language' #APIを使う
    require 'net/http'
    require 'json'
    # 
    # 
    puts params
    # binding.pry
    # @base64edpict = params[:test]
    # 
    # 
    
    # file = File.open('test.txt',"w")

    @params=params
    @params2=params[:test]
    puts "params[:test]"
    # puts params[:test]
    puts "@params2"
    # puts @params2
    #puts @params2 #=>Base64化された画像データ
    
    #ここからはGCPのvisionAPIへのアクセスです。
    #本来は以下見たいに環境変数にAPI KEYをセットしてURLとするのでしょうが、
    # URL = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['DO_GOOGLE_VISION_API_KEY']}"
    #今回は直接API KEYを埋め込みます
    url = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyCOYTVym6HtrwRTs3w1jkkYVzNupifDpLE"
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
      puts "------res.body------"
      puts res.body.class #=>このままではres.bodyはstring型です。
      # p res.body.inspect

      @resbody=res.body
      @hash = JSON.parse(res.body) #=>String型なres.bodyをJSON形式に変えます。
      puts @hash.class #=>hash
      puts "-----@hash.inspect-----"
      # p @hash.inspect
      p "-----@hash['responses'][0]['textAnnotations'][0]['description']-----"
      # puts @hash["responses"]
      puts @hash["responses"][0]["textAnnotations"][0]["description"]
      @hashdescription=@hash["responses"][0]["textAnnotations"][0]["description"]
      # 上の@hashdescriptionがOCRの結果の文字列です。newcameraビューで表示している内容です。

      #----------------------------ここまでが、画像からOCR。下はテキストから構文解析
      url = 'https://language.googleapis.com/v1/documents:analyzeEntities?key=AIzaSyANgufgAmLBF4I11wEKPJ2CuL4resK7qMg'
      #こちらはGCPのNaturalLanguageAPIの方のキーです。
      
      #Net::HTTPでAPIへリクエストを発行する
      uri           = URI.parse(url)
      https         = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      #リクエストにパラメーターをセットする
      req                 = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      text=@hashdescription
      param               = {
        "document": {
            "type": "PLAIN_TEXT",
            "language": "JA",
            "content": text
        },
        "encodingType": "UTF8"
      }
      req.body = param.to_json
      resNa      = https.request(req)
      resNa.body.force_encoding("UTF-8")
      puts "----------"
      puts resNa.body
      puts resNa.body.class
      resNajsoned= JSON.parse(resNa.body)
  end
  def createdata
    # puts "----createdata----"
    # puts params
    # params[:apiresulttext]=@hashdescription
    params[:apiresulttext].gsub!(/(\r\n?|\n|)/,"")
    # hidden_fieldのvalueにされたapiからの返答は改行コード(/r/n)がつくので除去します。
    # しかし、ここの置き換え後の文字は""にするか、 " "にするか検討が必要です。
    params[:apiresulttext].gsub!(" ","")
    params[:apiresulttext].gsub!("　","")
    # やはり、空白文字は全角半角すべて除去します。その状態でapiresulttextカラムに入れることにします。

    temp_sum=0
    for i in 0..69 do
      # デバッグ用表示
      # puts "i=#{i}, #{params[:apiresulttext][i]}, params[:apiresulttext][i].ord = #{params[:apiresulttext][i].ord}"
      temp_sum+=params[:apiresulttext][i].ord
    end
    # puts "temp_sum = #{temp_sum}"
    # 上のforループでapiからのOCR結果の文字中の70文字を文字コードに変えた値を足し込み、params[:apiresulthash]としてdbに保存します。
    params[:apiresulthash]=temp_sum
    @card = Card.new(card_params)
    if @card.save
      redirect_to card_path(@card.id)
    else
      redirect_to newcamera_path
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
      redirect_to card_path(@card.id) and return
    else
      redirect_to card_path(@card.id) and return
    end
  end
  def destroy
    card=Card.find(params[:id])
    # binding.pry
    if current_user.id != card.user_id
      redirect_to root_path
    end
    card.destroy
    redirect_to cards_path
  end
  private
  def card_params 
    params.permit(:name, :company, :department, :address, :tel,:email,:apiresulttext,:apiresulthash).merge(user_id: current_user.id)
  end
  def update_params 
    params.require(:card).permit(:name, :company, :department, :address, :tel,:email).merge(user_id: current_user.id)
  end
end
