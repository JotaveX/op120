const express = require('express');
const ususarioRoutes = require('./routes/usuario.routes');
const atividadeRoutes = require('./routes/atividade.routes');
const usuarioAtividadeRoutes = require('./routes/usuario-atividade.routes');

const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Define your routes here
app.use('/usuario', ususarioRoutes);
app.use('/atividade', atividadeRoutes);
app.use('/usuario-atividade', usuarioAtividadeRoutes);

app.listen(4000, () =>{
    console.log('Aberto na porta 4000');
});

app.get('/', (req, res)=>{
    res.send("Hello Word");
});