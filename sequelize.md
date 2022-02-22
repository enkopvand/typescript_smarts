# How to do sequelize + sequelize-auto with MSSQL and instanced domain servers in azure/windows VMs

npm i sequelize
npm i sequelize-auto

remember to install tedious as well, it's the mssql driver

# Shared:

```JavaScript
const user = 'username';
const pass = 'password';
const dbname = 'databasename';
const tediousServer = 'url\instanceName';
const seqServer = 'url'
const seqInstanceName = 'instanceName';
```

# test connect med tedious:

```JavaScript
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
```

Connect to MSSQL domain instance with sequlize:

```JavaScript
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
```

# How to auto generate tables with sequelize-auto

make a config json:

```JSON
{
  "host": "sqLServer", // update
  "database": "DBname", // update
  "dialect": "mssql",
  "dialectOptions": {
    "authentication": {
      "type": "default",
      "options": {
        "userName": "DBUSER", // udate
        "password": "PASS" // update
      }
    },
    "options": {
      "instanceName": "name", // update (this is the instancename in the server.com\ex2020 = ex2020)
      "encrypt": true
    },
    "lang": "ts",
    "directory": "./models"
    }
}
```

write in commandline:

```Console
node_modules\.bin\sequelize-auto -c DBtoModel.json -t "schema.table1" "schema.table2" "schema.table3"
```

As a js file:
(Note that the tables part doesn't seem to work)

```JavaScript
// eslint-disable-next-line @typescript-eslint/no-var-requires
const SequelizeAuto = require('sequelize-auto');

const auto = new SequelizeAuto('DBname', null, null, { // update
  host: 'sqLServer', // update
  dialect: 'mssql',
  dialectOptions: {
    authentication: {
      type: 'default',
      options: {
        userName: 'DBUSER', // update
        password: 'PASS', // update
      },
    },
    options: {
      instanceName: 'name', // update (this is the instancename in the server.com\ex2020 = ex2020)
      encrypt: true,
    },
    lang: 'ts',
    directory: './models',
    tables: ['schema.table1', 'schema.table2', 'schema.table3'],
  },
});
auto.run();
```
