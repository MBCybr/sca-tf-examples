variable "name" {
description = "name used for the sca profile"
type = string
default = "SCA policy built with TF and AWS SM"
}

variable "auth_url" {
  description = "Oauth2  URL for authentication"
  type        = string
}

variable "tenant_domain_name" {
  description = "Tenant sub domain name"
  type        = string
}

variable "platform_domain_name" {
  description = "platform domain name"
  type        = string
}

variable "username" {
  description = "SCA service user username"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "SCA service user password"
  type        = string
  sensitive   = true
}

variable "csp" {
  description = "The name of the cloud provider ('AWS','GCP','AZURE')"
  type        = string
}

variable "root_organization_id" {
  description = "Root Organization id"
  type        = string
}

variable "workspace_id" {
  description = "Workspace id"
  type        = string
}

variable "new_account" {
  description = "Is this new account"
  type        = bool
}

#Add the readonly permission set to the account Test ending in 1369 thats a member account in the aws org ending in 1369
variable "roles" {
  description = "List of CloudRoles"
  type        = list(map(string))

}

#Add the entra ID group or in this case the cyberark role for devs part of the ACME project
variable "identities" {
  description = "List of Identities"
  type        = list(map(string))

}

variable "start_date" {
  description = "Start date of the policy in ISO 8601 format"
  type        = string
  default     = null
}

variable "end_date" {
  description = "End date of the policy in ISO 8601 format"
  type        = string
  default     = null
}

variable "access_rules" {
  description = "Access rules for the policy"
  type        = object({
    days                 = list(string)
    from_time            = optional(string, null)
    to_time              = optional(string, null)
    max_session_duration = number
    time_zone            = string
  })
  default = null
}

# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in or pull resources from"
  type        = string
  default     = "us-east-2"  # You can change this to your preferred region
}

# AWS Profile (Optional, if you're using a specific AWS CLI profile)
variable "aws_profile" {
  description = "AWS CLI profile to use for authentication"
  type        = string
  default     = "default"  # Replace with your profile name if necessary
}

# The name of the secret in AWS Secrets Manager
variable "secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
  
}
