var rpc = require('json-rpc2');

var server = rpc.Server.$create({
  websocket: true,
  'headers': { // allow custom headers is empty by default
      'Access-Control-Allow-Origin': '*'
  }
});

server.on('error', function (err){
  console.log(err);
});

/* Expose two simple functions */
server.expose('add', function (args, opts, callback){
    if (args[0] !== 'leet') callback('not authenticated!')
    callback(null, args[1] + args[2]);
  }
);

server.expose('login', function(argsOne, argsTwo, callback) {
    console.log('LOGIN METHOD TOUCHED');
    console.log(`(${typeof argsOne}) argsOne=${argsOne}, (${typeof argsTwo}) argsTwo=${argsTwo}`)

    if (argsOne[0] === 'chuck' && argsOne[1] === 'norris') {
        callback(null, 'leet');
    } else {
        callback(null, false);
    }
})

server.exposeModule('system', {
    describe: function (args, opts, callback) {
        var data =     {
            "sdversion": "1.0",
            "name": "DemoService",
            "address": "http:\/\/127.0.0.1:5000\/",
            "id":"urn:md5:4e39d82b5acc6b5cc1e7a41b091f6590",
            "procs" :[
                {"name":"echo","params":["string"]}
            ]
        }
        callback(null, data)
    }
})

server.expose('multiply', function (args, opts, callback){
    callback(null, args[0] * args[1]);
  }
);

/* We can expose entire modules easily */
server.exposeModule('math', {
  power: function (args, opts, callback){
    callback(null, Math.pow(args[1], args[2]));
  },
  sqrt : function (args, opts, callback){
    callback(null, Math.sqrt(args[0]));
  }
});

/* By using a callback, we can delay our response indefinitely, leaving the
 request hanging until the callback emits success. */
server.exposeModule('delayed', {
    echo: function (args, opts, callback){
      var data = args[0];
      var delay = args[1];
      setTimeout(function (){
        callback(null, data);
      }, delay);
    },

    add: function (args, opts, callback){
      var first = args[0];
      var second = args[1];
      var delay = args[2];
      setTimeout(function (){
        callback(null, first + second);
      }, delay);
    }
  }
);

// or server.enableAuth('myuser', 'secret123');
// server.enableAuth(function(user, password){
//
//     console.log(`enableAuth handler has been called. (${typeof user}) user=${user} (${typeof password}) password=${password}`)
//   return user === 'chuck' && password === 'norris';
// });

/* HTTP/Websocket server on port 8088 */
server.listen(5000, 'localhost');

/* Raw socket server on port 8089 */
server.listenRaw(5001, 'localhost');

/* can handle everything in one port using */
// server.listenHybrid(8888, 'localhost');
