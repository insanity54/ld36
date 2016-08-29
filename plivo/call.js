var plivo = require('plivo-node');
var express = require('express');
var bodyParser = require('body-parser');
var app = express();

/**
 * root dir for sanity checks
 */
app.get('/', function(req, res) {
    res.set({'Content-Type': 'image/png'});
    res.send('./index.html');
});


/**
 * a call is received.
 *
 *   - announce app name and ask for an ID number.
 *   - if user enters digits, forward user to new endpoint
 *   - hangup if no digits received
 *
 */
app.post('/ld36/marshall.smith/call/', function(req, res) {
    //console.log(req.params);
    //var hangup = req.params['HangupCause'];
    //console.log('hangup: ' + hangup);
    var r = plivo.Response();

    // The digits pressed are send to this endpoint but because of
    // redirect: true, this endpoint is redirected to for further
    // processing and returning of XML instructions
    var digitOptions = {
        action: url.resolve(rootURL, '/response/sip/digits/'),
        redirect: "true",
        timeout: 5,     // first digit must be received within 3s
        digitTimeout: 2 // time between digits must not be greater than 2s
    };

    //r.addRecord(recordOptions);
    //r.addWait({length: "9"});
    var d = r.addGetDigits(digitOptions);
    d.addSpeak('enter your designator ID number');
    //d.addWait({length: "5"});
    r.addSpeak('end due to inaction');
    r.addHangup({"reason": "no designator ID number entered"});
    // var dial = r.addDial();
    // dial.addNumber('15099220951');
    //r.addWait({ length: "3" });

    // if (hangup) {
    //     res.end("SIP Route hangup callback");
    //     return;
    // }

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
