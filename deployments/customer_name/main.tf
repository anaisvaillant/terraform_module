
// backend is associated with where you want the logs stored
terraform {

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "dbt_cloud"

    workspaces {
      name = "dbt_cloud_workspace"
    }
  }

  required_version = ">= 1.3"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.71"
    }
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = ">= 0.2.20"
    }
  }
}

provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_username
  password = var.snowflake_password
}

provider "dbtcloud" {
  account_id = var.dbt_account_id
  token      = var.dbt_token
  host_url   = var.dbt_host_url
}

provider "github" {
  token = var.github_token
}


# to create Snowflake users/databases/roles/warehouses
module "dbtcloud_github_snowflake" {
  # source = "../dbt-terraform-modules/modules/combined/dbtcloud_github_snowflake"
    source = "github.com/anaisvaillant/dbt-terraform-modules//modules/combined/dbtcloud_github_snowflake"



  snowflake_account      = var.snowflake_account
  github_token           = var.github_token
  raw_database           = var.raw_database
  cruft_template_url     = var.cruft_template_url
  database_envs          = var.database_envs
  dbt_account_id         = var.dbt_account_id
  dbt_token              = var.dbt_token
  dbt_host_url           = var.dbt_host_url
  github_installation_id = var.github_installation_id
  dbt_version            = var.dbt_version
  project_name           = var.project_name
  developers             = var.developers

}

