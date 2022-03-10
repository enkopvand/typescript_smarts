Required:
Azure Functions Core Tools.
Azure CLI
Node.js
Docker

Step-by-step:

func init --worker-runtime node --language typescript --docker

func new --name HttpExample --template "HTTP trigger" --authlevel anonymous

func new --name bdode --template "HTTP trigger" --authlevel anonymous

npm install
npm start

update Dockerfile to:
FROM mcr.microsoft.com/azure-functions/node:4-node16 (or more modern)
https://hub.docker.com/_/microsoft-azure-functions-node

docker build --tag appname:v1.0.0 .

docker run -p 8080:80 -it appname:v1.0.0


docker build --tag helios-func-doc2data:v1.0.0 .
docker run -p 8080:80 -it helios-func-doc2data:v1.0.0
