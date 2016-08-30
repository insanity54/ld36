var plivo = require('plivo-node');
var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var path = require('path');

/**
 * serve static
 */
app.use(express.static('dist'));
app.use(bodyParser.urlencoded({ extended: false })); // Required for parsing POST
app.use(bodyParser.json()); // parse application/json

/** SMS received **/
app.post('/ld36/sms', function(req, res) {
    console.log(req.body);
    var sender = req.body["From"];
    var senderMessage = req.body['Text'];

    var r = plivo.Response();
    var smsOptions = {};

    // Pete's Ext
    if (senderMessage == 'A382' || senderMessage == 'a382') {
      smsOptions['text'] = "x843p_33.32.12.txt.hex";
    }

    // Sara's Ext
    else if (senderMessage == 'DV47' || senderMessage == 'dv47') {
      smsOptions['text'] = 'x666p_66.66.66.txt.hex';
    }

    // Marshall's Ext
    else if (senderMessage == '43E0' || senderMessage == '43e0') {
      smsOptions['text'] = 'x448p_21.21.21.txt.hex';
    }

    // Dr. Destin's Ext
    else if (senderMessage == '88Z2' || senderMessage == '88z2') {
      smsOptions['text'] = 'x903p_48.83.52.txt.hex';
    }


    else {
      smsOptions['text'] = "Network Engineers Frontier SMS Gateway. Reply with your extension."
    }

    smsOptions['src'] = '15092625208';
    smsOptions['dst'] = sender;

    r.addMessage(smsOptions.text, smsOptions);
    console.log(r.toXML());

    res.set({
        'Content-Type': 'text/xml'
    });
    res.end(r.toXML());

});


app.post('/ld36/marshall.smith/hangup/', function(req, res) {
  //console.log('hangup check');
  //console.log(req.query);
  var hangup = req.params['HangupCause'];
  var id = req.params['CallUUID'];

  if (hangup) {
      console.log("This call is done! call id: "+id+" HangupCause: "+hangup);
  }

  return res.status(200).send('THANKS FOR LETTING ME KNOW');
});

app.listen(process.env.PORT || 5000);
console.log('listening on %s', process.env.PORT || 5000);
