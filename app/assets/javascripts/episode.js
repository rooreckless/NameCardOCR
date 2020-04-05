$(function(){
  $('#showepisode__startedit').on('click',function(){
  $('#showepisode__startedit').css('display','none');
  $('.showepisode__form--readonly').removeAttr('readonly');
  $('#showepisode__form__updatebtn').css('display','');
  $('#showepisode__rebertedit').css('display','');
});
  $('#showepisode__rebertedit').on('click',function(){
  $('#showepisode__startedit').css('display','');
  $('.showepisode__form--readonly').attr('readonly');
  $('#showepisode__form__updatebtn').css('display','none');
  $('#showepisode__rebertedit').css('display','none');
  window.location.reload();
});

});
