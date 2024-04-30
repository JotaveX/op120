const express = require('express');
const router = express.Router();
const tokenController = require('../controller/app/token.controller');

router.post('/', tokenController.createToken);

module.exports = router;