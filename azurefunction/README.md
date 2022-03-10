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

http://localhost:8080/api/HttpExample?name=jacob

http://localhost:8080/api/bdode?name=jacob


create
resource group
functions appp

setup
deploymentslot on function app


create pipeline

change pipeline to (or don't use diffrent users for azure devops and portal)
```yaml
trigger:
  - main

jobs:
  - job: BuildDockerImage
    displayName: 'Build Docker Image'
    pool:
      vmImage: 'ubuntu-latest'
    steps:
      - task: Docker@2
        inputs:
          containerRegistry: 'DemoPipeline Docker Registry' # Your docker registry service connection
          repository: 'Repository Name' # Your docker repository name
          command: 'buildAndPush'
          Dockerfile: '**/Dockerfile'
          addPipelineData: false
          addBaseImageData: false
```

In Azure DevOps navigate to Pipelines => Releases => New => New release pipeline



