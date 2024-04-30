const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
    // Verificar se o token JWT está presente no cabeçalho da requisição
    const token = req.headers.authorization;

    if (!token) {
        return res.status(401).json({ message: 'Token de autenticação não fornecido' });
    }

    try {
        // Verificar e decodificar o token JWT
        const decoded = jwt.verify(token, 'chave_secreta');

        // Adicionar o ID do usuário decodificado ao objeto de requisição
        req.userId = decoded.userId;

        // Chamar o próximo middleware ou rota
        next();
    } catch (error) {
        return res.status(401).json({ message: 'Token de autenticação inválido' });
    }
};

module.exports = authMiddleware;