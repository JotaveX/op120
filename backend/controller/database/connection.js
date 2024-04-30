var knex = require('knex')({
    client: 'mysql',
    connection: {
        host: 'localhost',
        port: '3306',
        user: 'root',
        password: 'root',
        database: 'opt120'
    }
});
module.exports = knex;