const express = require('express');
const router = express.Router();
const usuarioAtividadeController = require('../controller/app/usuario-atividade.controller');
const authMiddleware = require('../controller/middleware/auth.middleware');


router.get('/', authMiddleware, usuarioAtividadeController.getUsuarioAtividade);
router.get('/:id', authMiddleware, usuarioAtividadeController.getUsuarioAtividadeById);
router.post('/', authMiddleware , usuarioAtividadeController.createUsuarioAtividade);
router.put('/:id', authMiddleware, usuarioAtividadeController.updateUsuarioAtividade);
router.delete('/:id', authMiddleware, usuarioAtividadeController.deleteUsuarioAtividade);

module.exports = router;
