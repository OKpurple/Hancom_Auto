'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _utils = require('../utils');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var router = _express2.default.Router();

router.get('/:id/:page', function (req, res) {
  var memberid = req.params.id;
  var _page = req.params.page;
  var page = _page * 10;
  var nextPage = 'http://211.253.8.229:8080/api/autoplanesult/' + memberid + '/' + (_page + 1);
  (0, _utils.dbConnect)(res).then(function (conn) {
    (0, _utils.query)(conn, res, '\n      SELECT * FROM auto_plan_result\n      WHERE Registrant = ?\n      ORDER BY start_date\n      LIMIT ?,10;\n    ', [memberid, page]).then(function (result) {
      if (result.length === 0) {
        res.json(_utils.INVALID_REQUEST);
      } else {
        res.json(tores(_utils.SUCCESS, {
          data: result
        }));
      }
    });
  });
});

router.get('/:id', function (req, res) {
  var memberid = req.params.id;
  var nextPage = 'http://211.253.8.229:8080/api/autoplanesult/' + memberid + '/1';
  console.log(nextPage);
  (0, _utils.dbConnect)(res).then(function (conn) {
    (0, _utils.query)(conn, res, '\n      SELECT * FROM auto_plan_result\n      WHERE Registrant = ?\n      ORDER BY start_date\n      LIMIT 0,10;\n    ', [memberid]).then(function (result) {
      if (result.length === 0) {
        res.json(_utils.INVALID_REQUEST);
      } else {
        res.json((0, _utils.toRes)(_utils.SUCCESS, {
          data: result,
          next: nextPage
        }));
      }
    });
  });
});

exports.default = router;