Required:
Azure Functions Core Tools.
Azure CLI
Node.js
Docker

Step-by-step:

func init --worker-runtime node --language typescript --docker

func new --name HttpExample --template "HTTP trigger" --authlevel anonymous

docker build --tag appname:v1.0.0 .

docker run -p 8080:80 -it appname:v1.0.0

