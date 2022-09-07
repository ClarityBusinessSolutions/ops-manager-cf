# Variables for MongoDB AMI build

# Required variables

variable "ops_manager_version" {
  type        = string
  description = <<-EOD
    The version of MongoDB Ops Manager to install.
    At this time, only versions 5.0.x are supported.
    See https://www.mongodb.com/try/download/ops-manager for all available versions.
    EOD
  default    = "5.0.14.100.20220802T1010Z-1"
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
}