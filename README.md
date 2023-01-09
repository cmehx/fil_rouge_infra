# fil_rouge_infra

GitHub action to successfully authentication between your repository and Azure

Create Azure service principal
Configure GitHub secrets

Terraform state file setup
Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.


Configure what is required to store terraform state file remotely within an Azure storage account

Deploy Terraform Base
This lab is the first part of deploying terraform, known as base; it will deploy:

Resource Group
Azure Container Registry (ACR)
Log Analytics
Application Insights

Build and deploy application to ACR
Time to Build and deploy the application to Azure Container Registry (ACR).


Update Secrets for github
Configured Application Insights to application
Update workflow in GitHub action to build and deploy application

Deploy Container App using Terraform
Now that the test application has been built and deployed into ACR, time to deploying the container app with image built on previous stage 4-build-deploy-application-to-acr

deploy using Terraform:

Azure Container Environment
Azure Managed Identity
Azure IAM to allow the Managed Identity acrpull permissions from the ACR previously created
Azure Container App with Managed Identity and deploy application into Container App

Monitoring and alerting
The purpose of this lab is to review and setup sample monitoring and alerting.


Use and review Application Insights logs and metrics
Setup an Application Insights Availability test
Use and review Log Analytics along with container insights

Deployment Overview
Once we commit a change to the source code – we want the Container Application to have been deployed with the latest commit automatically.

