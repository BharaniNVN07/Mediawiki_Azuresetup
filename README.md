# Mediawiki_Azuresetup
This Repository have all the required terraform code to deploy the Mediawiki application on Azure cloud.

#### Pre-requisites to use this github code :
1.Azure Account with an active subscription.
2.Service principal account with contributor access on the subscription.
3.Terraform installed machine or Azure Devops active project.
4.Azure storage account and container to store the terraform state file.

#### Steps to execute this project
All you need to have a local machine with terraform installed and download the code locally.
Create a parent directory and place the downloaded code in that directory, then initilise & Deploy the resources with terraform commands.
- Terraform init
- Terraform fmt
- Terraform plan
- Terraform Apply

#### steps to authenticate the azure using terrfaorm
I have defined all the required necessary variables as sensitive for Azure Authentication from terraform. 
We can directly pass the input variable details in tfvars files or we can pass the variable values with terraform apply as a runtime execution.
we can also define the variables values as environement varaibles using below commands, then we can apply the terraform.

- $ export ARM_CLIENT_ID=""
- $ export ARM_CLIENT_SECRET=""
- $ export ARM_SUBSCRIPTION_ID=""
- $ export ARM_TENANT_ID=""
