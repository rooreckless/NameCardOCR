$(function(){
  $('#groupnew_inner__show__btns--starteditbtn').on('click',function(){
    // 編集するボタンを押したとき
  $('#groupnew_inner__show__btns--starteditbtn').css('visibility','hidden');
  $('.groupnew_inner__show__form').removeAttr('readonly');
  $('#groupnew_inner__show__form--updatebtn').css('visibility','visible');
  $('#groupnew_inner__show__btns--reberteditbtn').css('visibility','visible');
  $('#groupnew_inner__show__btns--destroybtn').css('visibility','hidden');
  $('.groupnew_inner__show__input--password').css('visibility','visible');
  $('.groupnew_inner__show__input--passwordconfirm').css('visibility','visible');
});
  $('#groupnew_inner__show__btns--reberteditbtn').on('click',function(){
    // 編集をやめるボタンを押したとき
  $('#groupnew_inner__show__btns--starteditbtn').css('visibility','visible');
  $('.groupnew_inner__show__form').attr('readonly');
  $('#groupnew_inner__show__form--updatebtn').css('visibility','hidden');
  $('#groupnew_inner__show__btns--reberteditbtn').css('visibility','hidden');
  $('#groupnew_inner__show__btns--destroybtn').css('visibility','visible');
  $('.groupnew_inner__show__input--password').css('visibility','hidden');
  $('.groupnew_inner__show__input--passwordconfirm').css('visibility','hidden');
  window.location.reload();
});

});