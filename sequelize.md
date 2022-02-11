# How to do sequelize + sequelize-auto with MSSQL and instanced domain servers in azure/windows VMs

npm i sequelize
npm i sequelize-auto

remember to install tedious as well, it's the mssql driver

# Shared:

```javascript
const user = 'username';
const pass = 'password';
const dbname = 'databasename';
const tediousServer = 'url\instanceName';
const seqServer = 'url'
const seqInstanceName = 'instanceName';
```

# test connect med tedious:

´´´
const { Connection } = require('tedious');

const config = {
  server: s, // update me
  authentication: {
    type: 'default',
    options: {
      userName: u, // update me
      password: p, // update me
    },
  },
  options: {
    // If you are on Microsoft Azure, you need encryption:
    encrypt: true,
    database: dbname, // update me
  },
};
const connection = new Connection(config);
connection.on('connect', function (err) {
  // If no error, then good to proceed.
  console.log('Connected');
});

connection.connect();
´´´

Connect to MSSQL domain instance with sequlize:

´´´
const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(dbname, null, null, {
  host: seqServer,
  dialect: 'mssql',
  dialectOptions: {
    authentication: {
      type: 'default',
      options: {
        userName: user,
        password: pass,
      },
    },
    options: {
      instanceName: seqInstanceName,
      encrypt: true,
    },
  },
});
´´´

# How to auto generate tables with sequelize-auto

make a config json:

´´´
{
  "dialectOptions": {
    "authentication": {
      "type": "default",
      "options": {
        "userName": "user",
        "password": "pass"
      }
    },
    "options": {
      "instanceName": "instanceName",
      "encrypt": true
    }
    }
}
´´´

write in commandline:

node_modules\.bin\sequelize-auto -h seqServer -e mssql -c test.json -l ts -o "./models" -d dbName -s schemaName -t tableName
