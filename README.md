# sequila-recipes
SeQuiLa recipes, examples and other cloud-related content

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