GitHub action for successful authentication between your repository and Azure

Create an  Azure backend service
Set up GitHub secrets

Configuring the Terraform Status File
Terraform must store the state of your managed infrastructure and configuration. This state is used by Terraform to map real-world resources to your configuration, track metadata, and improve the performance of large infrastructures.


Configure what is required to store the terraform report file remotely in an Azure storage account

Deploy Terraform Base

Resource Group
Azure Container Registry (ACR)
Log analysis
Application Information

Create and deploy an application to ACR
It's time to build and deploy the application to Azure Container Registry (ACR).


Update secrets for github
Configuring Application Insights on the application
Update the workflow in the GitHub action to create and deploy an app

Deploy a container application using Terraform
Now that the test application has been built and deployed in ACR, it is time to deploy the container application with the built image - build-deploy-application-to-acr

deploy using Terraform:

Azure container environment
Azure Managed Identity
Azure IAM to allow acrpull Managed Identity permissions from the previously created ACR
Azure container application with managed identity and deployment of the application in the AKS container application.

Monitoring and alerting
Notifications a channel of slack
Monitoring and log 
Use and review Log Analytics with container insights
Deployment Overview
Once we've validated a source code change, we want the container app to have been deployed automatically with the last commit.

