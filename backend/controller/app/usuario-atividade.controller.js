const database = require('../database/connection');
const usuarioAtividadeModel = require('../../model/usuario-atividade.model');

class usuarioAtividadeController{
    createUsuarioAtividade(req,res){
        let usuarioAtividade = new usuarioAtividadeModel;
        
        usuarioAtividade = req.body;

        console.log(usuarioAtividade);

        database.insert(usuarioAtividade).table("usuario_atividade").then(data=>{
            console.log(data);
            res.json({message:"Usuario Atividade criado com sucesso!"})
        }).catch(error=>{
            res.json(error);
        });
    }

    getUsuarioAtividade(req,res){
        database.select("*").table("usuario_atividade").then(data=>{
            res.json(data);
        }).catch(error=>{
            res.json(error);
        })
    }

    getUsuarioAtividadeById(req,res){
        let id = req.params.id;
        database.select("*").table("usuario_atividade").where({id:id}).then(data=>{
            res.json(data);
        }).catch(error=>{
            res.json(error);
        })
    }

    updateUsuarioAtividade(req,res){
        let id = req.params.id;
        let usuarioAtividade = new usuarioAtividadeModel;
        usuarioAtividade = req.body;

        database.where({id:id}).update(usuarioAtividade).table("usuario_atividade").then(data=>{
            res.json({message:"Usuario Atividade atualizado com sucesso!"})
        }).catch(error=>{
            res.json(error);
        });
    }

    deleteUsuarioAtividade(req,res){
        let id = req.params.id;

        database.where({id:id}).del().table("usuario_atividade").then(data=>{
            res.json({message:"Usuario Atividade deletado com sucesso!"})
        }).catch(error=>{
            res.json(error);
        });
    }
}

module.exports = new usuarioAtividadeController();