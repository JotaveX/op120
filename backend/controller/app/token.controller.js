const database = require('../database/connection');
const usuarioModel = require('../../model/usuario.model');
const usuarioController = require('./usuario.controller');
const jwt = require('jsonwebtoken');

class tokenController {
    async createToken(req, res) {
        const { email, senha } = req.body;

        if(!email || !senha) {
            return res.status(400).json({ message: 'Email e senha são obrigatórios' });
        }

        try {
            const usuario = await database.select('*').table('usuario').where({ email }).first();

            if(!usuario) {
                return res.status(404).json({ message: 'Usuário não encontrado' });
            }

            if(!await usuarioController.checkPassword(senha, usuario.senha)) {
                return res.status(401).json({ message: 'Senha inválida' });
            }

            const token = jwt.sign({ userId: usuario.id }, 'chave_secreta', { expiresIn: '1h' });

            return res.status(200).json({ token });
        } catch (error) {
            return res.status(500).json({ message: 'Erro interno no servidor', error: error.message });
        }
    }
};

module.exports = new tokenController();