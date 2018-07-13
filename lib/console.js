jQuery(function($) {
    var ul;
    $('body').terminal('//127.0.0.1:5000/', {
        login: true,
        greetings: null,
        completion: true,
        keydown: function(e) {
            console.log('keydown!');
            var term = this;
            // setTimeout because terminal is adding characters in keypress
            // we use keydown because we need to prevent default action for
            // tab and still execute custom code
            setTimeout(function() {
                console.log('timeout!')
                ul.empty();
                var command = term.get_command();
                var name = command.match(/^([^\s]*)/)[0];
                if (name) {
                    var word = term.before_cursor(true);
                    var regex = new RegExp('^' + $.terminal.escape_regex(word));
                    var list;
                    if (name == word) {
                        list = Object.keys(commands);
                    } else if (command.match(/\s/)) {
                        if (commands[name]) {
                            if (word.match(/^--/)) {
                                list = commands[name].options.map(function(option) {
                                    return '--' + option;
                                });
                            } else {
                                list = commands[name].args;
                            }
                        }
                    }
                    if (word.length >= 2 && list) {
                        var matched = [];
                        for (var i=list.length; i--;) {
                            if (regex.test(list[i])) {
                                matched.push(list[i]);
                            }
                        }
                        var insert = false;
                        if (e.which == 9) {
                            insert = term.complete(matched);
                        }
                        if (matched.length && !insert) {
                            ul.hide();
                            for (var i=0; i<matched.length; ++i) {
                                var str = matched[i].replace(regex, '');
                                $('<li>' + str + '</li>').appendTo(ul);
                            }
                            ul.show();
                        }
                    }
                }
            }, 0);
            if (e.which == 9) {
                return false;
            }
        }
    });
});

console.log('hear me roar')
