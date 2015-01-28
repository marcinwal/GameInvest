

var xhr = new XMLHttpRequest();

  xhr.onload = function(){
    if (xhr.status === 200){
      responseObject = JSON.pasre(xhr.responseText);

      var newContent = '';
      for(var i = 0; i < responseObject.price.length; i++){
        newContent += '<div class="price">';
        newContent += '<p><b>' + responseObject.list.resources[i].resource.fields.price + '</b></p>'
        newContent += '</div>'
      }

      document.getElementId('content').innerHTML = newContent;
    }
};

xhr.open('GET', 'http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json', true);
xhr.send(null);
