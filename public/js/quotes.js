(function($) {
    function getStock(opts, type, complete) {
        var defs = {
            desc: false,
            baseURL: 'http://query.yahooapis.com/v1/public/yql?q=',
            query: {
                quotes: 'select * from yahoo.finance.quotes where symbol = "{stock}" | sort(field="{sortBy}", descending="{desc}")',
                historicaldata: 'select * from yahoo.finance.historicaldata where symbol = "{stock}" and startDate = "{startDate}" and endDate = "{endDate}"'
            },
            suffixURL: {
                quotes: '&env=store://datatables.org/alltableswithkeys&format=json&callback=?',
                historicaldata: '&env=store://datatables.org/alltableswithkeys&format=json&callback=?'
            }
        };
 
        opts = opts || {};
 
        if (!opts.stock) {
            complete('No stock defined');
            return;
        }
 
        var query = defs.query[type]
        .replace('{stock}', opts.stock)
        .replace('{sortBy}', defs.sortBy)
        .replace('{desc}', defs.desc)
        .replace('{startDate}', opts.startDate)
        .replace('{endDate}', opts.endDate)
 
        var url = defs.baseURL + query + (defs.suffixURL[type] || '');
        $.getJSON(url, function(data) {
            var err = null;
            if (!data || !data.query) {
                err = true;
            }
            complete(err, !err && data.query.results);    });
    }
    window.getStock = getStock;
})(jQuery);

var getApple = function(){
   getStock({ stock: 'AAPL' }, 'quotes', function(err, data) {
    // console.log(data);
    return data
  });
};

//http://jsfiddle.net/asgallant/dSWe7/


function drawTable () {
    // use jQuery to make an AJAX request for data
    $.ajax({
        url: 'http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json',
        dataType: 'jsonp',
        success: function (json) {
            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Name');
            data.addColumn('string', 'Symbol');
            data.addColumn('number', 'Price');
            data.addColumn('date', 'UTC Time');
            
            // parse the JSON into the DataTable
            for (var i = 0; i < json.list.resources.length; i++) {
                var name = json.list.resources[i].resource.fields.name;
                var symbol = json.list.resources[i].resource.fields.symbol;
                var price = parseFloat(json.list.resources[i].resource.fields.price);
                var dateTimeArr = json.list.resources[i].resource.fields.utctime.split('T');
                var dateArr = dateTimeArr[0].split('-');
                var year = dateArr[0];
                var month = dateArr[1] - 1; // subtract 1 to make compatible with javascript dates
                var day = dateArr[2];
                var timeArr = dateTimeArr[1].split(/[:\+]/);
                var hour = timeArr[0];
                var minute = timeArr[1];
                var second = timeArr[2];
                
                data.addRow([name, symbol, price, new Date(year, month, day, hour, minute, second)]);
            }
            
            var table = new google.visualization.Table(document.querySelector('#table_div'));
            table.draw(data);
        }
    });
};


