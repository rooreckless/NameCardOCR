$(function(){
  function buildNormalSearchResult(data){
    console.log("---buildNormalSearchResult---");
    console.log(data);
    console.log(data.cards);
    console.log(data.cards.length);
    var returnHTML =
    `<div class="searchnormform-inner__results__row">
    <p class="searchnormform-inner__results__row--title">検索結果 (全 ${data.cards.length} 件)</p><br>
    <input type="text" class="searchnormform-inner__results__row--number" value="No" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--name" value="名前" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--company" value="会社名" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--department" value="部署名" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--address" value="住所" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--tel" value="TEL" readonly="true">
    <input type="text" class="searchnormform-inner__results__row--email" value="mail" readonly="true">
    </div>`;
    for (var i=0;i<data.cards.length;i++){
      returnHTML+=
      `
      <hr>
      <div class="searchnormform-inner__results__row">
      <input type="text" class="searchnormform-inner__results__row--number" value="${i+1}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--name" value="${data.cards[i].name}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--company" value="${data.cards[i].company}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--department" value="${data.cards[i].department}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--address" value="${data.cards[i].address}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--tel" value="${data.cards[i].tel}" readonly="true">
      <input type="text" class="searchnormform-inner__results__row--email" value="${data.cards[i].email}" readonly="true">
      <a class="searchnormform-inner__results__row--link" href='/cards/${data.cards[i].id}'>詳細</a>
      </div>
      
      `;
    }
    console.log(returnHTML);
    return returnHTML;
  }

  $('#card__startedit').on('click',function(){
    // 名刺情報を編集するボタンを押したとき
  $('#card__startedit').css('visibility','hidden');
  $('.showcard_left__cardform__row--input').removeAttr('readonly');
  $('#card__updatebtn').css('visibility','visible');
  $('#card__rebertedit').css('visibility','visible');
  $('#card__destroybtn').css('visibility','hidden');

  $('#card_name').attr('placeholder','名前を入力');
  $('#card_company').attr('placeholder','会社名を入力');
  $('#card_department').attr('placeholder','部署名を入力');
  $('#card_address').attr('placeholder','住所を入力');
  $('#card_tel').attr('placeholder','電話番号を入力');
  $('#card_email').attr('placeholder','メールアドレスを入力');
  });
  $('#card__rebertedit').on('click',function(){
    // 名刺情報の編集をやめるボタンを押したとき
  $('#card__startedit').css('visibility','visible');
  $('.showcard_left__cardform__row--input').attr('readonly');
  $('#card__updatebtn').css('visibility','hidden');
  $('#card__rebertedit').css('visibility','hidden');
  $('#card__destroybtn').css('visibility','visible');
  window.location.reload();
  });
  $('#searchnormform-inner__form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);
    console.log(formdata);
    var url = $(this).attr('action');
    console.log(url);
    $.ajax({
      url: url,
      type: "POST",
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      console.log("---done---");
      console.log(data);
      console.log(data.length);
      var html=buildNormalSearchResult(data);
      $('.searchnormform-inner__results').html('');
      $('.searchnormform-inner__results').append(html);
      // 検索ボタンは再度おせるようになりますが、2秒後です。
      setTimeout(function(){$('#card__normalsearchstartbtn').attr('disabled',false);}, 2000);
    }).fail(function(){
      alert('検索エラーが発生しました。');
    });
  });
});
