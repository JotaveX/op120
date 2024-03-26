const database = require('../database/connection');
const usuarioModel = require('../../model/usuario.model')

class usuarioController{
    createUsuario(req,res){
        let usuario = new usuarioModel;
        
        usuario = req.body;

        console.log(usuario);


        database.insert(usuario).table("usuario").then(data=>{
            console.log(data);
            res.json({message:"Usuario criado com sucesso!"})
        }).catch(error=>{
            res.error(error);
        });
    }

    getUsuario(req,res){
        database.select("*").table("usuario").then(data=>{
            res.json(data);
        }).catch(error=>{
            res.error(error);
        })
    }
}

module.exports = new usuarioController();   