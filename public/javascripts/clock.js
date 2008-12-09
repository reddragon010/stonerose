// Anytime Anywhere Web Page Clock Generator
// Clock Script Generated at
// http://www.rainbow.arch.scriptmania.com/tools/clock

function timeSource(){
   x=new Date(timeNow().getUTCFullYear(),timeNow().getUTCMonth(),timeNow().getUTCDate(),timeNow().getUTCHours(),timeNow().getUTCMinutes(),timeNow().getUTCSeconds());
   x.setTime(x.getTime()+3600000);
   return x;
}
function timeNow(){
   return new Date();
}
function leadingZero(x){
   return (x>9)?x:'0'+x;
}
function fixYear2(x){
   x=(x<500)?x+1900:x;
   return String(x).substring(2,4)
}
function displayTime(){
   if(fr==0){
      fr=1;
      document.write('<span id="tP">'+eval(outputTime)+'</span>');
   }
   document.getElementById('tP').innerHTML=eval(outputTime);
   setTimeout('displayTime()',1000);
}
var dayNames=new Array('Son','Mon','Die','Mit','Don','Fre','Sam');
var monthNames=new Array('Jan','Feb','Mrz','Apr','Mai','Jun','Jul','Aug','Sep','Okt','Nov','Dez');
var fr=0;
var outputTime="dayNames[timeSource().getDay()]+' '+timeSource().getDate()+' '+monthNames[timeSource().getMonth()]+' '+fixYear2(timeSource().getYear())+' '+':'+':'+' '+leadingZero(timeSource().getHours())+':'+leadingZero(timeSource().getMinutes())+':'+leadingZero(timeSource().getSeconds())+' '";



// Use the following within your HTML to Start/display your clock
// <script language="JavaScript">displayTime();</script>