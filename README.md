# sequila-recipes
SeQuiLa recipes, examples and other cloud-related content demonstrating
how to run SeQuila jobs in the cloud.
For most tasks we use [Terraform](https://www.terraform.io/downloads.html) as a main IaC (Infrastrucrure as Code) tool.

# Status
## GCP

* [Dataproc](#Dataproc) :white_check_mark: 
* GKE (Google Kubernetes Enging) :white_check_mark:

## Azure
* Databricks: :interrobang:
* HDInsight: :soon:
* AKS (Azure Kubernetes Service): :soon: 

## AWS
* EMR: :soon:
* EKS(Elastic Kubernetes Service): :soon:

# Setup pre-commit checks
1. Activate pre-commit integration
```bash
pre-commit install
```
2. Install pre-commit hooks  [deps](https://github.com/antonbabenko/pre-commit-terraform#1-install-dependencies)



# Azure
## Login
Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
```bash
az login
```
# Databricks
## Login
1. Install [databricks-cli](https://docs.databricks.com/dev-tools/cli/index.html)
2. Generate PAT from [Databricks UI](https://docs.databricks.com/dev-tools/api/latest/authentication.html)
3. Configure cli 
```bash
databricks configure --token
```
4. Check if `~/.databrickscfg` file has been generated

# GCP

## Login
```bash
gcloud auth application-default login
# set default project
gcloud config set project tbd-tbd-devel
```


## Dataproc
### Deploy
```bash
terraform apply -var-file=env/gcp-dataproc.tfvars
```
### Run
```bash
gcloud workflows execute pysequila-workflow --location europe-west2
```
or from GCP UI Console:
![img.png](doc/images/dataproc-workflow.png)

