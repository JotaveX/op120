const express = require('express');
const router = express.Router();
const AtividadeController = require('../controller/app/atividade.controller');
const authMiddleware = require('../controller/middleware/auth.middleware');

// Define your activity routes here

router.get('/', authMiddleware, AtividadeController.getAtividade);
router.get('/:id', authMiddleware, AtividadeController.getAtividadeById);
router.post('/', authMiddleware, AtividadeController.createAtividade);
router.put('/:id', authMiddleware, AtividadeController.updateAtividade);
router.delete('/:id', authMiddleware, AtividadeController.deleteAtividade);

module.exports = router;
