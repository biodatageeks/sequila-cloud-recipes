# sequila-recipes
![example workflow](https://github.com/biodatageeks/sequila-cloud-recipes/actions/workflows/default.yml/badge.svg?branch=master)

SeQuiLa recipes, examples and other cloud-related content demonstrating
how to run SeQuila jobs in the cloud.
For most tasks we use [Terraform](https://www.terraform.io/downloads.html) as a main IaC (Infrastructure as Code) tool.

Table of Contents
=================

* [Disclaimer](#disclaimer)
* [Demo scenario](#demo-scenario)
* [Modules statuses](#modules-statuses)
    * [GCP](#gcp)
    * [Azure](#azure)
    * [AWS](#aws)
* [Azure](#azure-1)
    * [Login](#login)
* [Databricks](#databricks)
    * [Login](#login-1)
* [GCP](#gcp-1)
    * [Login](#login-2)
    * [General GCP setup](#general-gcp-setup)
    * [Dataproc](#dataproc)
        * [Deploy](#deploy)
        * [Run](#run)
        * [Cleanup](#cleanup)
    * [GKE](#gke)
        * [Deploy](#deploy-1)
        * [Run](#run-1)
* [Development and contribution](#development-and-contribution)
    * [Setup pre-commit checks](#setup-pre-commit-checks)

    
# Disclaimer
These are NOT production-ready examples. Terraform modules and Docker images are scanned/linted with tools such
as [checkov](https://www.checkov.io/), [tflint](https://github.com/terraform-linters/tflint) and [tfsec](https://github.com/aquasecurity/tfsec)
but some security tweaks have been disabled for the sake of simplicity. Some cloud deployments best practices has been intentionally skipped
as well. Check code comments for details.

# Demo scenario
1. The presented scenario can be deployed on one of the main cloud providers: Azure(Microsoft), AWS(Amazon) and GCP(Google).
2. For each cloud two options are presented - deployment on managed Hadoop ecosystem (Azure - HDInsight, AWS - EMR, GCP - Dataproc) or
or using managed Kubernetes service (Azure - AKS, AWS - EKS and GCP - GKE).
3. Scenario includes the following steps:
   1. setup distributed object storage
   2. copy test data
   3. setup computing environment
   4. run a test PySeQuiLa job using PySpark
# Modules statuses
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
1. Install [Cloud SDK](https://cloud.google.com/sdk/docs/install)
2. Authenticate
```bash
gcloud auth application-default login
# set default project
gcloud config set project tbd-tbd-devel
```

## General GCP setup
1. Set GCP project-related env variables, e.g.:
```bash
export TF_VAR_project_name=tbd-tbd-devel
export TF_VAR_region=europe-west2
export TF_VAR_zone=europe-west2-b
```
Above variables are necessary for both `Dataproc` and `GKE` setups.

## Dataproc
### Deploy
```bash
terraform apply -var-file=env/gcp.tfvars -var-file=env/gcp-dataproc.tfvars
```
### Run
```bash
gcloud workflows execute pysequila-workflow --location ${TF_VAR_region}
```
or from GCP UI Console:
![img.png](doc/images/dataproc-workflow.png)

![img.png](doc/images/dataproc-job.png)

### Cleanup
```bash
terraform destroy -var-file=env/gcp.tfvars -var-file=env/gcp-dataproc.tfvars
```
## GKE
### Deploy
```bash
terraform apply -var-file=env/gcp.tfvars -var-file=env/gcp-gke.tfvars
```

### Run
1. Connect to the K8S cluster, e.g.:
```bash
gcloud container clusters get-credentials ${TF_VAR_project_name}-cluster --zone ${TF_VAR_zone} --project ${TF_VAR_project_name}
# check connectivity
kubectl get nodes
NAME                                                  STATUS   ROLES    AGE   VERSION
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-8wqh   Ready    <none>   25m   v1.21.5-gke.1302
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-dlr1   Ready    <none>   25m   v1.21.5-gke.1302
gke-tbd-tbd-devel-cl-tbd-tbd-devel-la-cb515767-r5l3   Ready    <none>   25m   v1.21.5-gke.1302
```
2. Install [sparkctl](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/tree/master/sparkctl) (recommended) or use `kubectl`: \
:bulb: Please replace references to staging bucket with your bucket, e.g.
```yaml
mainApplicationFile: gs://tbd-tbd-devel-staging/jobs/pysequila/sequila-pileup-gke.py
```
```bash
sparkctl create jobs/gcp/gke/pysequila.yaml
```
After a while you will be able to check the logs:
```bash
sparkctl log -f pysequila
```

# Development and contribution
## Setup pre-commit checks
1. Activate pre-commit integration
```bash
pre-commit install
```
2. Install pre-commit hooks  [deps](https://github.com/antonbabenko/pre-commit-terraform#1-install-dependencies)


