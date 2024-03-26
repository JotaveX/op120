const express = require('express');
const router = express.Router()
const TaskController = require('../controller/app/usuario.controller')
var bodyParser = require('body-parser')

var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

router.post('/user', urlencodedParser, TaskController.createUsuario);
router.get('/user',urlencodedParser, TaskController.getUsuario);

module.exports = router;