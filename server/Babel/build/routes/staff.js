'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _utils = require('../utils');

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var router = _express2.default.Router();

router.post('/signin', function (req, res) {
  var memberid = req.body.memberid;
  var pw = req.body.pw;
  (0, _utils.dbConnect)(res).then(function (conn) {
    (0, _utils.query)(conn, res, 'SELECT NAME,memberid,team,EMAIL FROM staff WHERE memberid = ? AND pw = ?', [memberid, pw]).then(function (result) {
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

router.delete('/logout', function (req, res) {});

exports.default = router;