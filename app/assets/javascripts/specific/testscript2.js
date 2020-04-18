$(function(){
  console.log('===this message is testscript2.js===');
  var reloadTestConsole = function(){
    console.log('--reloadTestConsole-2222-');
  }
  setInterval(reloadTestConsole, 7000);
});