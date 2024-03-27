const express = require('express');
const router = express.Router();
const usuarioAtividadeController = require('../controller/app/usuario-atividade.controller');
var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

router.get('/', usuarioAtividadeController.getUsuarioAtividade);
router.get('/:id', usuarioAtividadeController.getUsuarioAtividadeById);
router.post('/', jsonParser, usuarioAtividadeController.createUsuarioAtividade);
router.put('/:id', jsonParser, usuarioAtividadeController.updateUsuarioAtividade);
router.delete('/:id', usuarioAtividadeController.deleteUsuarioAtividade);

module.exports = router;
