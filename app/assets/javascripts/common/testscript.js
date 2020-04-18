$(function(){
  console.log('===this message is testscript.js===');
  var reloadTestConsole = function(){
    console.log('--reloadTestConsole--');
  }
  setInterval(reloadTestConsole, 7000);
});