variable "db_tools_version" {
  type        = string
  description = <<-EOD
    The version of MongoDB Database Tools to install.
    See https://www.mongodb.com/try/download/database-tools for all available versions.
    EOD
  default     = "100.5.2"
}

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