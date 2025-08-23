terraform {
  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "5.86.0"
    }
    sca = {
      # Provider version is 1.0.0
      source = "cyberark/sca/sca"
    }    
  }
}

provider "sca" {
    auth_url             = var.auth_url
  tenant_domain_name   = var.tenant_domain_name
  platform_domain_name = var.platform_domain_name
    username = local.secret_data["username"]
  password = local.secret_data["password"]
}

data "sca_discovery" "discovery_example" {
  csp             = var.csp
  organization_id = var.root_organization_id
  account_info    = {
    id          = var.workspace_id
    new_account = var.new_account
  }
}

resource "sca_policy" "policy_example" {

  depends_on = [data.sca_discovery.discovery_example]
	name = var.name
  csp        = var.csp
  roles      = var.roles
  identities = var.identities
  access_rules = var.access_rules
  end_date     = var.end_date
  start_date   = var.start_date
}

# Define the AWS provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile  # Optional, if you're using a named AWS profile
}


# Retrieve secret from AWS Secrets Manager
data "aws_secretsmanager_secret" "example" {
  name = var.secret_name  # The name of the secret in Secrets Manager
}

data "aws_secretsmanager_secret_version" "example_version" {
  secret_id = data.aws_secretsmanager_secret.example.id
}

# Assuming secret is in JSON format with 'username' and 'password' keys
locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.example_version.secret_string)
}
