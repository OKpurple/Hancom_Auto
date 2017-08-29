'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _express = require('express');

var _express2 = _interopRequireDefault(_express);

var _staff = require('./staff');

var _staff2 = _interopRequireDefault(_staff);

var _auto_plan_result = require('./auto_plan_result');

var _auto_plan_result2 = _interopRequireDefault(_auto_plan_result);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var router = _express2.default.Router();

router.use('/staff', _staff2.default);
router.use('/autoplanresult', _auto_plan_result2.default);
exports.default = router;