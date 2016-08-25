"use strict";
const db      = module.parent.require('./database');
const hotswap = module.parent.require('./hotswap');

const nconf   = module.parent.require('nconf');
const async   = module.parent.require('async');

let plugin = {};
var getItems = function(callback) {
  if (plugin.cache) {
    return callback(null, plugin.cache);
  } else {
  	db.get('plugins:anime-items', function(err, data) {
    	try {
        plugin.cache = (JSON.parse(data) || []).map(function(obj) {
          obj.json_string = JSON.stringify(obj);
          return obj;
        });

        console.log('replacements', replacements);

        callback(null, plugin.cache);
      } catch (err) {
        callback(err);
      }
  	});
  }
};

var renderAdmin = function(req, res) {
	getItems(function(err, data) {
		res.render('admin/admin-page', {
			data: data
		});
	});
};

var AnimeItem = {
  admin: {
    menu: function(custom_header, callback) {
      custom_header.plugins.push({
        "route": '/plugins/anime-item',
        "icon": 'fa-edit',
        "name": 'Anime Manager'
      });
      callback(null, custom_header);
    }
  },
	init: function(params, callback) {
    console.log('init call');
    let app = params.router;
    let middleware = params.middleware;

    app.get('/admin/plugins/anime-item', middleware.admin.buildHeader, renderAdmin);
    app.get('/api/admin/plugins/anime-item', renderAdmin);

    var SocketAdmin = module.parent.require('./socket.io/admin');

    SocketAdmin.settings.saveMarks = function(socket, data, callback) {
      delete plugin.cache;

      async.series([
        async.apply(db.set, 'plugins:anime-items', JSON.stringify(data))
      ], callback);
    };
		callback();
  }
};

module.exports = AnimeItem;
