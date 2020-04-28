// getUserMedia が使えないときは、『getUserMedia()が利用できないブラウザです』と言ってね。
  if (typeof navigator.mediaDevices.getUserMedia !== 'function') {
    const err = new Error('getUserMedia()が利用できないブラウザです');
    alert(`${err.name} ${err.message}`);
    throw err;
}
// 操作する画面エレメント変数定義します。
const $video = document.getElementById('video_area');  // 映像表示エリア

// スタートボタン押下まちでなく、このページが開かれたら(そしてDOMの読み込みが完了したら)カメラが起動します。
document.addEventListener('DOMContentLoaded', () => {
    navigator.mediaDevices.getUserMedia({ video: {
      // スマホのバックカメラを使用
      facingMode: 'environment'
  }, audio: false })
    .then(stream => $video.srcObject = stream)
    .catch(err => alert(`${err.name} ${err.message}`));
}, false);

function buildHTMLbeforecreate(DuplexCards_inGroup,DuplexCards_inUser){
  var returnHTML=``;
  if ((DuplexCards_inGroup.length > 0)||(DuplexCards_inUser.length > 0)){
    returnHTML+=`<span class="animationEmRed">${(DuplexCards_inGroup.length)+(DuplexCards_inUser.length)}件の名刺と重複していると思われます。</span><br>所属グループ内やあなたがすでに登録した名刺と重複すると、エピソードの記入に支障がでるおそれがあります。<br>撮影した名刺を登録して問題がないか確認してください。<div class="searchresults__row">
        <input type="text" class="searchresults__row--name" readonly="true" value="名前">
        </input>
        <input type="text" class="searchresults__row--company" readonly="true" value="会社名">
        </input>
        <input type="text" class="searchresults__row--department" readonly="true" value="部署名">
        </input>
        <input type="text" class="searchresults__row--tel"  readonly="true" value="tel">
        </input>
        <input type="text" class="searchresults__row--email"  readonly="true" value="mail">
        </input>
        <div class="searchresults__row--goshowcard">
          
        </div>
  </div><hr>`;
  
    if (DuplexCards_inGroup.length > 0){
      returnHTML+=`所属グループにてすでに登録済みと思われる名刺 ${DuplexCards_inGroup.length}件`
      for (var i=0;i<DuplexCards_inGroup.length;i++){
        returnHTML+=`<div class="searchresults__row">
              <input type="text" class="searchresults__row--name" readonly="true" value=${DuplexCards_inGroup[i].name}>
              </input>
              <input type="text" class="searchresults__row--company" readonly="true" value=${DuplexCards_inGroup[i].company}>
              </input>
              <input type="text" class="searchresults__row--department" readonly="true" value=${DuplexCards_inGroup[i].department}>
              </input>
              <input type="text" class="searchresults__row--tel" readonly="true" value=${DuplexCards_inGroup[i].tel}>
              </input>
              <input type="text" class="searchresults__row--email" readonly="true" value=${DuplexCards_inGroup[i].email}>
              </input>
              
              <a href="/cards/${DuplexCards_inGroup[i].id}" class="searchresults__row--goshowcard">詳細確認</a>
        </div><hr>`
        ;
        }
    }
    if (DuplexCards_inUser.length > 0){
      returnHTML+=`あなたが個人として登録済みと思われる名刺 ${DuplexCards_inUser.length}件`
      for (var i=0;i<DuplexCards_inUser.length;i++){
        returnHTML+=`<div class="searchresults__row">
              <input type="text" class="searchresults__row--name" readonly="true" value=${DuplexCards_inUser[i].name}>
              </input>
              <input type="text" class="searchresults__row--company" readonly="true" value=${DuplexCards_inUser[i].company}>
              </input>
              <input type="text" class="searchresults__row--department" readonly="true" value=${DuplexCards_inUser[i].department}>
              </input>
              <input type="text" class="searchresults__row--tel" readonly="true" value=${DuplexCards_inUser[i].tel}>
              </input>
              <input type="text" class="searchresults__row--email" readonly="true" value=${DuplexCards_inUser[i].email}>
              </input>
              
              <a href="/cards/${DuplexCards_inUser[i].id}" class="searchresults__row--goshowcard">詳細確認</a>
        </div><hr>`;
        }
    }
    returnHTML+=`<span class="drawCanvas__after__createbeforesearchresults--confbtn" id="create_beforesearch--confbtn"onclick="go_step4()">重複に問題がないため続ける</span><span class="drawCanvas__after__createbeforesearchresults--reloadbtn id="winreloadbtn" onclick="pagereload()">別の画像を使用する</span>`;
  }else{
    // この領域は、「これから作成しようとする名刺データが、所属グループとも、ユーザ個人にも重複してはいない」場合になりますが、その際はHTMLを生成しないので、空です。
  }
  return returnHTML;
}
// 「撮影」ボタンが押されたら「<canvas id="capture_image">」に映像のコマ画像を表示します。(次のステップ2へ移行。)
function go_step2() {

  var canvas_capture_image = document.getElementById('capture_image');
  var cci = canvas_capture_image.getContext('2d');
  var va = document.getElementById('video_area');

  canvas_capture_image.width  = va.videoWidth;
  canvas_capture_image.height = va.videoHeight;
  cci.drawImage(va, 0, 0);  // canvasに『「静止画取得」ボタン』押下時点の画像を描画。
  // 撮影確認領域と撮影用ボタンを排除
  $('.newcamera__step1').css('display','none');
  $('.newcamera__step2').css('display','block');
  $('.newcamera__step3').css('display','none');
  $('.newcamera__step4').css('display','none');
  $('#drawCanvas').css('display','block');
}
// 取り直しボタンを押されたときの挙動(ステップ1へ戻る)
function rebert_step1(){
  $('.newcamera__step1').css('display','block');
  $('.newcamera__step2').css('display','none');
  $('.newcamera__step3').css('display','none');
  $('#createbeforesearchresults').css('display','none');
  $('#createbeforesearchresults').empty();
  $('.newcamera__step4').css('display','none');
}
// ページのリロードメソッド
function pagereload(){
  location.reload();
}
// ページ内スクロールメソッド
function pagescroll(target){
  var top_pos = target.offset().top;
  $(".newcamera_body").animate({ scrollTop: top_pos }, 'slow','swing');
}
// ステップ4(登録フォームの表示)へ移行するメソッド。
function go_step4(){
  $('.newcamera__step3__warning').css('display','none');
  $('.newcamera__step4').css('display','block');
  // 
  pagescroll($('#drawCanvas__after--message'));
  // var top_pos = $('#drawCanvas__after--message').offset().top;
  // console.log(top_pos);
  // $(".newcamera_body").animate({ scrollTop: top_pos }, 'slow','swing');
}
// 使用する写真が決定したときの挙動(ステップ2からステップ3へ移行)
function drawCanvas(){
  var canvas = $('#capture_image').get(0);
  if (canvas.getContext){ // 未サポートブラウザでの実行を抑止
    var ctx = canvas.getContext('2d');
    // 描画用のコードを記述
  }
  // 取得した画像のbase64化
  var canvasbase64 = canvas.toDataURL('image/png');
  var splited_canvasbase64 = canvasbase64.split(",");
  // base64化されたデータのうち、GoogleCloudVisionAPIへと投げたいデータのみに分けるため","で配列分けし、[1]要素をajaxで渡します。
  
  // ajax通信開始(コントロラーラ→api→返答をもらう)
  $.ajax({
    url: '/cards/createajax',
    type: "POST",
    data: {test: splited_canvasbase64[1]},
    dataType: 'json',
    // processData: false,
    // contentType: false,
  }).done(function(data){
    // ajax通信完了後です。data.hashdescriptionには認識後の文字データが入っています。
    // フォームを出現させ、認識結果の表示と記入用フォームがでてきます。
    $('#base64result').text(data.hashdescription);
    $('.newcamera__step3').css('display','block');
    $('#hiddenapiresulttext').val(data.hashdescription);
    $('#drawCanvas').css('display','none');
    //フォームの内容にあらかじめいれられる内容を記入します(NLApiの結果です。あてはまらなくてnullでも可です。)
    //このフォームは、重複登録の可能性がある場合は、値は入れるものの非表示にし、重複ではないと確認されてから表示されます。
    $('#name').val(data.nlResultPerson);
    $('#company').val(data.nlResultOrg);
    $('#address').val(data.nlResultAddress);
    $('#tel').val(data.nlResultPhone);
    $.ajax({
      // 2段目のajax通信
      // ここは新しく名刺を作る際に検索をかけて、グループ内に同様な名刺がないかを調べます。(重複チェック)
      // url: '/cards/searchbeforecreatecard',
      url: '/cards/searchajax',
      type: "POST",
      data: {test: data.hashdescription},
      dataType: 'json',
    }).done(function(data){
      //2段目ajax通信の結果
      if((data.cards_inGroup.length > 0) ||(data.cards_inUser.length > 0)){
        // data.cards_inGroupがこれから登録しようとしている名刺がグループ内で重複している場合のデータ
        // data.cards_inUserがこれから登録しようとしている名刺がユーザ個人として登録しているなかで重複している場合のデータ
        // これらを使用して重複している可能性のあるデータを表示します。
        var html=buildHTMLbeforecreate(data.cards_inGroup,data.cards_inUser);
        $('#createbeforesearchresults').empty();
        $('#createbeforesearchresults').append(html);
        $('#createbeforesearchresults').css('display','block');
        pagescroll($('#createbeforesearchresults'));
      }else{
        // 重複していないなら、入力用フォームを表示します。
        go_step4();
      }
    }).fail(function(){
      //2段目ajax通信の結果(エラー)
      alert("エラーが発生しました。名刺の重複登録の可能性を検索中にエラーが発生しました。このメッセージの後、ページを再読み込みします。");
      location.reload();
    });
  }).fail(function(){
    //1段目ajax通信の結果(エラー)
    alert("エラーが発生しました。画像から文字を全く認識できなかった可能性があります。このメッセージの後、ページを再読み込みします。");
    location.reload();
  });
}