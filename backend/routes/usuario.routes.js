const express = require('express');
const router = express.Router()
const TaskController = require('../controller/app/usuario.controller')
var bodyParser = require('body-parser')

var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

router.post('/', jsonParser, TaskController.createUsuario);
router.get('/', TaskController.getUsuario);
router.get('/:id', TaskController.getUsuarioById);
router.put('/:id', jsonParser, TaskController.updateUsuario);
router.delete('/:id', TaskController.deleteUsuario);


module.exports = router;