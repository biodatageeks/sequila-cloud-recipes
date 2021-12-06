# sequila-recipes
![example workflow](https://github.com/biodatageeks/sequila-cloud-recipes/actions/workflows/default.yml/badge.svg?branch=master)

SeQuiLa recipes, examples and other cloud-related content demonstrating
how to run SeQuila jobs in the cloud.
For most tasks we use [Terraform](https://www.terraform.io/downloads.html) as a main IaC (Infrastructure as Code) tool.

# Status
## GCP

* [Dataproc](#Dataproc) :white_check_mark: 
* GKE (Google Kubernetes Engine) :white_check_mark:

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
terraform apply -var-file=env/gcp.tfvars -var-file=env/gcp-dataproc.tfvars
```
### Run
```bash
gcloud workflows execute pysequila-workflow --location europe-west2
```
or from GCP UI Console:
![img.png](doc/images/dataproc-workflow.png)


## GKE
### Deploy
```bash
terraform apply -var-file=env/gcp.tfvars -var-file=env/gcp-gke.tfvars
```

### Run
1. Connect to the K8S cluster, e.g.:
```bash
gcloud container clusters get-credentials tbd-tbd-devel-cluster --zone europe-west2-b --project tbd-tbd-devel
# check connectivity
 kubectl get nodes
NAME                                                  STATUS   ROLES    AGE   VERSION
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-8wqh   Ready    <none>   25m   v1.21.5-gke.1302
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-dlr1   Ready    <none>   25m   v1.21.5-gke.1302
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-r5l3   Ready    <none>   25m   v1.21.5-gke.1302

```
2. 