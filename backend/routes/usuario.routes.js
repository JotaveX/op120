const express = require('express');
const router = express.Router()
const TaskController = require('../controller/app/usuario.controller')
const authMiddleware = require('../controller/middleware/auth.middleware');

router.post('/', TaskController.createUsuario);
router.get('/', authMiddleware, TaskController.getUsuario);
router.get('/:id', authMiddleware, TaskController.getUsuarioById);
router.put('/:id', authMiddleware, TaskController.updateUsuario);
router.delete('/:id', authMiddleware, TaskController.deleteUsuario);


module.exports = router;