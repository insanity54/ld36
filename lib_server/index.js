var rpc = require('json-rpc2');
var Datastore = require('nedb')
var path = require('path');
var crypto = require('crypto');
var validator = require('validator');
var Promise = require('bluebird');
var InvalidRequest = rpc.Error.InvalidRequest;

/**
 * REFERENCE SECTION
 *
 * how I was generated salt--
 *   var salt = crypto.randomBytes(64).toString('base64');
 */


var server = rpc.Server.$create({
    'websocket': true, // is true by default
    'headers': { // allow custom headers is empty by default
        'Access-Control-Allow-Origin': '*'
    }
});

var db = {};
db.users = new Datastore({
    filename: path.join(__dirname, '..', 'data', 'users.nedb'),
    autoload: true
});

db.users.update({
    username: 'chuck',
}, {
    username: 'chuck',
    password: '41f1873059714a944f7494028094e96a571e10b5e4414f293068476b27f8acc738363572e80fce7d60d627802134752f108786408e2d77bd59061c8e6474df62',
    salt: 'qYN3Qm/a6Re8gAsNbY0b3KIUYBegzUdLDPupmMLJuknf9xrLGiXzgO7BGB6jWvjwL43IiY5Hb8NXyGwu5G60qA=='
}, {
    upsert: true
});


function hashPassword(password, salt) {
    // hash the password the user entered
    return new Promise(function (resolve, reject) {

        if (typeof password === 'undefined' || typeof salt === 'undefined')
            reject('password or salt passed to hashPassword was undefined!')

        console.log(typeof password);
        console.log(`hashing password with salt.\nPASSWORD:\n  ${password}\nSALT:\n  ${salt}`);
        crypto.pbkdf2(password, salt, 100000, 64, 'sha512', (err, derivedKey) => {
            if (err) reject(err);
            console.log(`HASH:\n  ${derivedKey.toString('hex')}`);  // '3745e48...08d59ae'
            resolve({
                hash: derivedKey.toString('hex'),
                salt: salt
            });
        });
    })
}


/**
 * create a token for the logged in user's session.
 * token is good until user invalidates token by logging out.
 */
function generateToken(username) {
    return new Promise((resolve, reject) => {
        var token = crypto.randomBytes(64).toString('base64');
        console.log(`time to generate a token!\nUSERNAME:\n  ${username}\nTOKEN:\n  ${token}`)
        db.users.update({
                username: username
            },
            { $set: { token: token }},
            {},
            function(err, numReplaced) {
                console.log(`UPDATE changed ${numReplaced} documents.`)
                if (err) reject(err);
                resolve(token);
            });
    })
}


function getUser(username) {
    return new Promise(function (resolve, reject) {

        db.users.findOne({username: username}, function(err, doc) {
            if (err)
                reject('that user doesnt exist.');

            resolve(doc);
        });


    });
}



function validateInput(input) {
    return new Promise(function (resolve, reject) {

        var username = input[0];
        var password = input[1];
        if (!validator.isAscii(username, 'en-US'))
            return callback('username must contain only ASCII characters.')

        username = validator.escape(username);

        resolve({
            username: username,
            password: password
        })
    });
}





function verifyHashes(hashOne, hashTwo) {
    return new Promise((resolve, reject) => {
        if (hashOne !== hashTwo) reject('hashes do not match!');
        resolve();
    });
}




function login(userInput, request, callback) {

    console.log(`login attempt: user,pass=${userInput}`)
    console.log('「NEW」 ロギン　メサード　スタート！');


    return validateInput(userInput).then((i) => {
        // match hash in db with hash of submitted pw
        return getUser(i.username).then((u) => {
            console.log(`user get!\n${u}`)
            console.log(u);
            return hashPassword(i.password, u.salt).then((d) => {
                console.log(`password hashed. ${d}`)
                console.log(d);
                console.log(`let's compare\n  ${d.hash}\nand\n  ${u.password}`)
                return verifyHashes(d.hash, u.password).then(() => {
                    return generateToken(u.username).then((t) => {
                        console.log('大丈夫！')
                        callback(null, t);
                    })
                })
            })
        })
    })
    .catch((e) => {
        console.error(`過失! ${e}`);
        callback(e);
        //return false // tell auth that user is NOGO
    })

}

/**
 * using a token passed to us from a client,
 * get the associated user account, if any.
 */
function getUserByToken(token) {
    return new Promise((resolve, reject) => {
        if (typeof token === 'undefined')
            reject('getUserByToken was not passed a token!');

        console.log(`getting user by token.\nTOKEN: ${token}}`)
        db.users.findOne({ token: token }, function(err, doc) {
            if (err) reject(err);
            if (doc === null) reject('Not authorized! try `login`');
            resolve(doc);
        });
    });
}

// function ensureAuth(token) {
//     return new Promise((resolve, reject) => {
//         if (typeof token === 'undefined')
//             reject('ensureAuth was not passed a token!')
//
//         return getUserByToken(token).then((u) => {
//             console.log('got user ');
//             console.log(u);
//             if (typeof u === 'undefined') reject('user is not authorized!')
//             resolve('user is authorized.')
//         })
//     })
// }


/**
 * sum the two numbers passed as arguments
 */
function add(args, opt, callback) {
    return getUserByToken(args[0]).then(() => {
        callback(null, args[1] + args[2]);
    }).catch((e) => {
        console.log('oh, I guess no adding then')
        callback(e, 'nein!');
    });
}

function help(args, opt, callback) {
    const helpPrompt = `
    1) MMR    ..........  Multi Mail Reader
    2) XDB    ..........  X-Database
    3) CARVE  ..........  Computer Aided Remote Viewing
    4) CAGI   ..........  Computer Aided Cognitive Inception
    5) MARC   ..........  Message Archive
    6) ESOL   ..........  Execute Secure Logout`;

    console.log(args);
    console.log(opt);
    
    return getUserByToken(args[0]).then(() => {
        callback(null, helpPrompt)
    });
}


server.expose('help', help);
server.expose('add', add);
server.expose('login', login);

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


// you can expose an entire object as well:

server.expose('dectile', {
    'function1': function(){},
    'function2': function(){},
    'function3': function(){}
});
// expects calls to be namespace.function1, namespace.function2 and namespace.function3

// listen creates an HTTP server on localhost only
const port = 5000;
server.listen(port, 'localhost');
console.log(`server started on port ${port}`);
