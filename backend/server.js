const express = require('express');
const Router = require('./routes/usuario.routes');

const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(Router);

app.listen(4000, () =>{
    console.log('Aberto na porta 4000');
});

app.get('/', (req, res)=>{
    res.send("Hello Word");
});