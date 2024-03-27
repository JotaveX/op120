const express = require('express');
const router = express.Router();
const AtividadeController = require('../controller/app/atividade.controller');

// Define your activity routes here

router.get('/', AtividadeController.getAtividade);
router.get('/:id', AtividadeController.getAtividadeById);
router.post('/', AtividadeController.createAtividade);
router.put('/:id', AtividadeController.updateAtividade);
router.delete('/:id', AtividadeController.deleteAtividade);

module.exports = router;
