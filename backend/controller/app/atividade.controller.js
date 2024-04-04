const database = require('../database/connection');
const atividadeModel = require('../../model/atividade.model');

class atividadeController{
    createAtividade(req,res){
        let atividade = new atividadeModel;
        
        atividade = req.body;

        console.log(atividade);

        database.insert(atividade).table("atividade").then(data=>{
            console.log(data);
            res.json({message:"Atividade criada com sucesso!"})
        });
    }

    getAtividade(req,res){
        database.select("*").table("atividade").then(data=>{
            res.json(data);
        }).catch(error=>{
            res.json(error);
        })
    }

    getAtividadeById(req,res){
        let id = req.params.id;
        database.select("*").table("atividade").where({id:id}).then(data=>{
            res.json(data);
        }).catch(error=>{
            res.json(error);
        })
    }

    updateAtividade(req,res){
        let id = req.params.id;
        let atividade = new atividadeModel;
        atividade = req.body;

        database.where({id:id}).update(atividade).table("atividade").then(data=>{
            res.json({message:"Atividade atualizada com sucesso!"})
        }).catch(error=>{
            res.json(error);
        });
    }

    deleteAtividade(req,res){
        let id = req.params.id;

        database.where({id:id}).del().table("atividade").then(data=>{
            print(data);
            res.json({message:"Atividade deletada com sucesso!"})
        }).catch(error=>{
            res.json(error);
        });
    }
}

module.exports = new atividadeController();