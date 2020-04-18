$(function(){
  console.log('===this message is testscript2.js===');
  var reloadTestConsole = function(){
    console.log('--reloadTestConsole22222222--');
  }
  setInterval(reloadTestConsole, 7000);
});