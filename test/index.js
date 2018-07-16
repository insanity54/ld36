

const path = require('path');
const assert = require('chai').assert;
const app = require(path.join(__dirname, '..', 'lib_server', 'index'));
const rpc = require('json-rpc2');
const client = rpc.Client.$create(5000, 'localhost');



describe('app', () => {
  it('should serve JSON-RPC on port 5000', (done) => {
    // Call add function on the server
    client.call('add', [null, 1, 2], function(err, result) {
        assert.isNull(err);
        assert.equal(result, '3');
        done();
    });
  });
  
  it('should serve JSON-RPC login method', (done) => {
    client.call('login', ['pete', 'rosebud'], function(err, result) {
      assert.isDefined(err);
      assert.isNull(result);
      done();
    });
  });
  
  it('should serve system.describe JSON-RPC method', (done) => {
    client.call('system.describe', function(err, result) {
      assert.isNull(err);
      assert.isObject(result);
      done();
    });
  });
});

