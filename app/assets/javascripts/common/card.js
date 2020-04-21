$(function(){
  function buildNormalSearchResult(cards_inGroup,cards_inUser){
    var returnHTML=``;
        if ((cards_inGroup.length > 0)||(cards_inUser.length > 0)){
          returnHTML+=
          `<div class="searchnormform-inner__results__row">
            <p class="searchnormform-inner__results__row--title">検索結果 (全 ${(cards_inGroup.length)+(cards_inUser.length)} 件)</p><br>
            <input type="text" class="searchnormform-inner__results__row--number" value="No" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--name" value="名前" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--company" value="会社名" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--department" value="部署名" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--address" value="住所" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--tel" value="TEL" readonly="true">
            <input type="text" class="searchnormform-inner__results__row--email" value="mail" readonly="true">
          </div><hr>`;
        
          if (cards_inGroup.length > 0){
            returnHTML+=`<div class="searchnormform-inner__results--Group">所属グループで登録の名刺 ${cards_inGroup.length}件`
            for (var i=0;i<cards_inGroup.length;i++){
              returnHTML+=`
              <div class="searchnormform-inner__results__row">
                <input type="text" class="searchnormform-inner__results__row--number" value="${i+1}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--name" value="${cards_inGroup[i].name}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--company" value="${cards_inGroup[i].company}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--department" value="${cards_inGroup[i].department}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--address" value="${cards_inGroup[i].address}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--tel" value="${cards_inGroup[i].tel}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--email" value="${cards_inGroup[i].email}" readonly="true">
                <a class="searchnormform-inner__results__row--link btnrad btnrad--blue" href='/cards/${cards_inGroup[i].id}'>詳細</a>
              </div><hr>
              `;
              }
              returnHTML+=`</div>`
          }
          if (cards_inUser.length > 0){
            returnHTML+=`<div class="searchnormform-inner__results--User">あなたが個人として登録済みの名刺 ${cards_inUser.length}件`
            for (var i=0;i<cards_inUser.length;i++){
              returnHTML+=`
              <div class="searchnormform-inner__results__row">
                <input type="text" class="searchnormform-inner__results__row--number" value="${i+1}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--name" value="${cards_inUser[i].name}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--company" value="${cards_inUser[i].company}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--department" value="${cards_inUser[i].department}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--address" value="${cards_inUser[i].address}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--tel" value="${cards_inUser[i].tel}" readonly="true">
                <input type="text" class="searchnormform-inner__results__row--email" value="${cards_inUser[i].email}" readonly="true">
                <a class="searchnormform-inner__results__row--link btnrad btnrad--blue" href='/cards/${cards_inUser[i].id}'>詳細</a>
              </div><hr>
              `;
              }
              returnHTML+=`</div>`
          }
        }else{
          // この領域は、「これから作成しようとする名刺データが、所属グループとも、ユーザ個人にも重複してはいない」場合になりますが、その際はHTMLを生成しないので、空です。
        }
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

  $('#showcard_left_icon_company').css('display','none');
  $('#showcard_left_icon_address').css('display','none');
  $('#showcard_left_icon_tel').css('display','none');
  $('#showcard_left_icon_email').css('display','none');
  });

  $('#card__rebertedit').on('click',function(){
    // 名刺情報の編集をやめるボタンを押したとき
  $('#card__startedit').css('visibility','visible');
  $('.showcard_left__cardform__row--input').attr('readonly');
  $('#card__updatebtn').css('visibility','hidden');
  $('#card__rebertedit').css('visibility','hidden');
  $('#card__destroybtn').css('visibility','visible');
  
  $('#showcard_left_icon_company').css('display','block');
  $('#showcard_left_icon_address').css('display','block');
  $('#showcard_left_icon_tel').css('display','block');
  $('#showcard_left_icon_email').css('display','block');

  window.location.reload();
  });
  $('#searchnormform-inner__form').on('submit',function(e){
    e.preventDefault();
    var formdata = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formdata,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html=buildNormalSearchResult(data.cards_inGroup,data.cards_inUser);
      $('.searchnormform-inner__results').html('');
      $('.searchnormform-inner__results').append(html);
      // 検索ボタンは再度おせるようになりますが、2秒後です。
      setTimeout(function(){$('#card__normalsearchstartbtn').attr('disabled',false);}, 2000);
    }).fail(function(){
      alert('検索エラーが発生しました。');
    });
  });
});
