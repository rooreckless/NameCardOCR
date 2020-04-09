$(function(){
  $('#episode_inner__startedit').on('click',function(){
    // 編集するボタンを押したとき
  $('#episode_inner__startedit').css('display','none');
  $('.episode_inner__form--readonly').removeAttr('readonly');
  $('#episode_inner__form__updatebtn').css('display','');
  $('#episode_inner__rebertedit').css('display','block');
  $('#episode_inner__destroybtn').css('display','none');
});
  $('#episode_inner__rebertedit').on('click',function(){
    // 編集をやめるボタンを押したとき
  $('#episode_inner__startedit').css('display','');
  $('.episode_inner__form--readonly').attr('readonly');
  $('#episode_inner__form__updatebtn').css('display','none');
  $('#episode_inner__rebertedit').css('display','none');
  $('#episode_inner__destroybtn').css('display','block');
  window.location.reload();
});

});
