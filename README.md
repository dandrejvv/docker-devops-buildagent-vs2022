# docker-devops-buildagent-vs2022

A docker buildagent for Azure Devops using Visual Studio 2022 community edition.

## Disclaimer

I take no credit for any of this apart from making a few tweaks and bringing the following sources together to get a working docker image (that alone as been a big time effort put in from my end). I take no responsibility for any issues/harm/loss that arise from this so examine for yourself and use at own risk!

## Usage

### Legend

| Tag name | Meaning |
|-|-|
| devops_url | Your organization URL for Azure devops, eg. `https://dev.azure.com/orgname/` |
| devops_pat | See below at `AZP_Token` |
| acr-server | Your Azure Container Repository Server, eg. `yourreponame.azurecr.io` |
| acr-name | Your Azure Container Repository Name, eg. `yourreponame` |

### Build

> docker build -t buildtools:latest -m 2GB .

### Test locally

> docker run -e AZP_URL=`<devops_url>` -e AZP_TOKEN=`<devops_pat>` buildtools:latest

### Docker Environment Variables

| Variable | Description|
|-|-|
| AZP_URL | The URL of the Azure DevOps or Azure DevOps Server instance. |
| AZP_TOKEN | Personal Access Token (PAT) with Agent Pools (read, manage) scope, created by a user who has permission to configure agents, at AZP_URL. |
| AZP_TOKEN_FILE | Instead of passing through the token as a parameter, you can pass through the file name instead containing only the PAT token as content. Will require volume mounting, etc. |
| AZP_AGENT_NAME | Agent name (default value: the container hostname). |
| AZP_POOL | Agent pool name (default value: Default). |
| AZP_WORK | Work directory (default value: _work). |

_Source from [1] in references list below_

### Tag for repo

> docker tag buildtools:latest `<acr-server>`/buildtools:latest

### Login to Azure repo

> az login
>
> az acr login --name `<acr-name>`
>
> docker push `<acr-server>`/buildtools:latest

## Sources

1. [Run a self-hosted agent in Docker](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#windows)
2. [Stack-overflow: SSDT and vstest capability missing in container when installing Visual Studio Build Tools](https://stackoverflow.com/a/60191980/802755)
