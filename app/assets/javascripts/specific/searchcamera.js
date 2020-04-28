// getUserMedia が使えないときは、『getUserMedia()が利用できないブラウザです』と言ってね。
if (typeof navigator.mediaDevices.getUserMedia !== 'function') {
  const err = new Error('getUserMedia()が利用できないブラウザです');
  alert(`${err.name} ${err.message}`);
  throw err;
}
// 操作する画面エレメント変数定義します。
const $video = document.getElementById('video_area');  // 映像表示エリア

document.addEventListener('DOMContentLoaded', () => {
  navigator.mediaDevices.getUserMedia({ video: {
      // スマホのバックカメラを使用
      facingMode: 'environment'
  }, audio: false })
  .then(stream => $video.srcObject = stream)
  .catch(err => alert(`${err.name} ${err.message}`));
}, false);

function buildsearchresultHTML(cards_inGroup,cards_inUser){
  // 検索結果の件数をreturnHTMLに格納
  var returnHTML=`<p>検索結果 : ${cards_inGroup.length+cards_inUser.length}件</p>`;
  if((cards_inGroup.length > 0)||(cards_inUser.length > 0)){
    // 検索結果の各列名を格納
    returnHTML+=`<div class="searchresults__row">
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
    if(cards_inGroup.length > 0){
      returnHTML+=`所属グループにてすでに登録済みの名刺 ${cards_inGroup.length}件`
      for (var i=0;i<cards_inGroup.length;i++){ 
      returnHTML+=`<div class="searchresults__row">
            <input type="text" class="searchresults__row--name" readonly="true" value=${cards_inGroup[i].name}>
            </input>
            <input type="text" class="searchresults__row--company" readonly="true" value=${cards_inGroup[i].company}>
            </input>
            <input type="text" class="searchresults__row--department" readonly="true" value=${cards_inGroup[i].department}>
            </input>
            <input type="text" class="searchresults__row--tel" readonly="true" value=${cards_inGroup[i].tel}>
            </input>
            <input type="text" class="searchresults__row--email" readonly="true" value=${cards_inGroup[i].email}>
            </input>
            
            <a href="/cards/${cards_inGroup[i].id}" class="searchresults__row--goshowcard">詳細確認</a>
      </div><hr>`;
      }
    }
    if(cards_inUser.length > 0){
      returnHTML+=`あなたが個人として登録済みの名刺 ${cards_inUser.length}件`
      for (var i=0;i<cards_inUser.length;i++){ 
      returnHTML+=`<div class="searchresults__row">
            <input type="text" class="searchresults__row--name" readonly="true" value=${cards_inUser[i].name}>
            </input>
            <input type="text" class="searchresults__row--company" readonly="true" value=${cards_inUser[i].company}>
            </input>
            <input type="text" class="searchresults__row--department" readonly="true" value=${cards_inUser[i].department}>
            </input>
            <input type="text" class="searchresults__row--tel" readonly="true" value=${cards_inUser[i].tel}>
            </input>
            <input type="text" class="searchresults__row--email" readonly="true" value=${cards_inUser[i].email}>
            </input>
            
            <a href="/cards/${cards_inUser[i].id}" class="searchresults__row--goshowcard">詳細確認</a>
      </div><hr>`;
      }
    }
  }else{
    // 所属グループ、ユーザ個人としても検索できなかった場合の領域です。
  }
  return returnHTML;
}


// ページ内スクロールメソッド
function pagescroll(target){
  var top_pos = target.offset().top;
  console.log(target);
  $(".searchcamera_body").animate({ scrollTop: top_pos }, 'slow','swing');
}
// 撮影ボタンが押されたら「<canvas id="capture_image">」に映像のコマ画像を表示します。
function go_step2() {

    var canvas_capture_image = document.getElementById('capture_image');
    var cci = canvas_capture_image.getContext('2d');
    var va = document.getElementById('video_area');

    canvas_capture_image.width  = va.videoWidth;
    canvas_capture_image.height = va.videoHeight;
    cci.drawImage(va, 0, 0);  // canvasに『「静止画取得」ボタン』押下時点の画像を描画。
    // 撮影確認領域と撮影用ボタンを排除
    $('.searchcamera__step1').css('display','none');
    $('.searchcamera__step2').css('display','block');
    $('.searchcamera__step3').css('display','none');
}
function rebert_step1(){
  // 取り直しボタンを押されたときの挙動
  $('.searchcamera__step1').css('display','block');
  $('.searchcamera__step2').css('display','none');
  $('.searchcamera__step3').css('display','none');
  $('#searchresults').empty();
}
function drawCanvas(){
  // 使用する写真が決定して検索するときの挙動
  var canvas = $('#capture_image').get(0);
  if (canvas.getContext){ // 未サポートブラウザでの実行を抑止
    var ctx = canvas.getContext('2d');
    // 描画用のコードを記述
  }
  // 取得した画像のbase64化
  var canvasbase64 = canvas.toDataURL('image/png');

  var splited_canvasbase64 = canvasbase64.split(",");
 
  // ajax通信開始(コントローラ→api→返答をもらいます)
  $.ajax({
    url: '/cards/createajax',
    type: "POST",
    data: {test: splited_canvasbase64[1]},
    dataType: 'json',
    // processData: false,
    // contentType: false,
  }).done(function(data){
    // ajax通信完了。
    $('.searchcamera__step3').css('display','block');
    var resultdescription=data.hashdescription;
    // 2回目のajax通信(cards#searchajaxへ、文字認識結果を送り、検索結果を受け取ります)
    $.ajax({
      url: '/cards/searchajax',
      type: "POST",
      data: {test: resultdescription},
      dataType: 'json',})
      .done(function(data){
        // searchajax.json.jbuilderより、data.cardsが検索結果のカード達になります。
        var html=buildsearchresultHTML(data.cards_inGroup,data.cards_inUser)
        $('#searchresults').empty();
        $('#searchresults').append(html);
        pagescroll($('#searchresults'));
      })
      .fail(function(){
        alert("error search");
      });
  
  }).fail(function(){
    // 1段階目のajax通信結果(エラー)
    alert("エラーが発生しました。画像から文字を全く認識できなかった可能性があります。このメッセージの後、ページを再読み込みします。");
    location.reload();
  });
}