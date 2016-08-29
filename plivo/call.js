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
    throw 'thats what u get';
    var r = plivo.Response();
    var smsOptions = {
      message: "Network Engineers Frontier SMS Gateway. Reply with your party's extension.",
      src: "15092625208",
      dst: ""
    };
    r.addMessage()

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
