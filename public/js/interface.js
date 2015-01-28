console.log("Marcin and Richard");
var tmp;


pullQuotes = function(){
  getQuote('EURUSD=X');
  var bid = Math.round(10000 * price * bid_multiplier)/10000.0;
  var ask = Math.round(10000 * price * ask_multiplier)/10000.0;
  // if ((!bid.isNaN()) && (!ask.isNaN()))
  {
    $('#bid').text(bid);
    $('#ask').text(ask);
  }    
};

$('#sell').on('click',function(){
  tmp = document.getElementById('bid');
  $.get(
    "localhost",
    {side: "sell", price: tmp.textContent});
});

$('#buy').on('click',function(){
  tmp = document.getElementById('ask');
  $.get(
    "localhost",
    {side: "buy", price: tmp.textContent});
});

$(document).ready(function(){
  pullQuotes();
  google.load('visualization', '1', {packages:['table'], callback: drawTable});
});

setInterval(function(){
  pullQuotes(); 
}, 5000);
