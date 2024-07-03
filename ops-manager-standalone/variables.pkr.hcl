# Variables for MongoDB AMI build

# Required variables

variable "ops_manager_version" {
  type        = string
  description = <<-EOD
    The version of MongoDB Ops Manager to install.
    At this time, only versions 5.0.x are supported.
    See https://www.mongodb.com/try/download/ops-manager for all available versions.
    EOD
  default    = "7.0.8.500.20240627T1703Z"
}

variable "mongodb_major_version" {
  type        = string
  description = <<-EOD
    The version of MongoDB Database to install.
    See https://www.mongodb.com/try/download/enterprise-advanced/releases 
    for all current releases and 
    https://www.mongodb.com/try/download/enterprise-advanced/releases/archive
    for all archived rleases.
    EOD
  default     = "7.0"
}

variable "mongodb_patch_version" {
  type        = string
  description = <<-EOD
    The version of MongoDB Database to install.
    See https://www.mongodb.com/try/download/enterprise-advanced/releases 
    for all current releases and 
    https://www.mongodb.com/try/download/enterprise-advanced/releases/archive
    for all archived rleases.
    EOD
  default     = "7"
}

# Optional Variables
variable "source_ami_name" {
  type        = string
  description = <<-EOD
    Glob that will be used to search for the source AMI Name.
    The most recent match will be used.
    EOD
  default     = "RHEL-8*_HVM-*-x86_64-*-Hourly2-GP2"
}

variable "source_ami_owner" {
  type        = string
  description = <<-EOD
    AWS account ID that owns the source AMI.
    The default is the account ID for certified RedHat images.
    EOD
  default     = "309956199498"
}

variable "instance_type" {
  type        = string
  description = <<-EOD
    The AWS instance type to use for the AppDB Instances.
    EOD
  default     = "t3.large"
}

variable "region" {
  type        = string
  description = <<-EOD
    The AWS region to use for the AppDB Instances.
    EOD
  default     = "us-east-1"
}