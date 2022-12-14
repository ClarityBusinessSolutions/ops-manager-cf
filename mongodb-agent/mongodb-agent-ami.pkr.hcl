# Main packer configuration for the MongoDB Automation Agegent AMI

locals {
  # Use a common timestamp throughout
  ts = timestamp()
  # Timestamp formatted for use in the AMI Name
  name_ts = formatdate("YYYY.MM.DD.hh.mm", local.ts)
}

data "amazon-ami" "rhel-8" {
  filters =  {
    name                = var.source_ami_name
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = [var.source_ami_owner]
  region      = "us-east-1"
}

source "amazon-ebs" "mongodb-automation-agent" {
  source_ami        = data.amazon-ami.rhel-8.id
  ssh_username      = "ec2-user"
  instance_type     = "t3.medium"
  region            = "us-east-1"
  ebs_optimized     = true
  shutdown_behavior = "terminate"

  ami_name = "mongodb-automation-agent-image-mdb6-${local.name_ts}"

  ami_description = join(" ", [
    "MongoDB Automation Agent for Ops Manager 6.0.3 AMI."
  ])

  tags = {
    "Name"  = "MongoDB Automation Agent for Ops Manager 6.0.3"
    "description" = join(" ", [
      "MongoDB Automation Agent for Ops Manager 6.0.3 AMI."
    ])
    "build_time"        = local.ts
    "io.packer.version" = packer.version

    # Source AMI
    "source_ami.id"         = "{{ .SourceAMI }}"
    "source_ami.name"       = "{{ .SourceAMIName }}"
    "source_ami.owner.id"   = "{{ .SourceAMIOwner }}"
    "source_ami.owner.name" = "{{ .SourceAMIOwnerName }}"

    # Software versions
    "com.mongodb.db_tools.version"         = var.db_tools_version
  }

  launch_block_device_mappings {
    # Root volume
    device_name           = "/dev/sda1"
    volume_size           = 80
    volume_type           = "gp2"
    delete_on_termination = true
  }

  run_tags = {
    "Owner"             = "Packer builder"
    "build_time"        = local.ts
    "description"       = <<-EOD
      MongoDB AMI ephemeral build instance.
      Launched by Packer.
      EOD
    "io.packer.version" = packer.version
  }

  run_volume_tags = {
    "Owner"             = "Packer builder"
    "build_time"        = local.ts
    "description"       = <<-EOD
      MongoDB AMI ephemeral build instance.
      Launched by Packer.
      EOD
    "io.packer.version" = packer.version
  }
}

build {
  sources = ["source.amazon-ebs.mongodb-automation-agent"]

  provisioner "file" {
    source      = "../shared/resources/"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "echo 'Waiting for cloud-init ...'",
      "sudo cloud-init status --wait || true"
    ]
  }

  provisioner "shell" {
    script = "../shared/scripts/yum_init"
  }

  provisioner "shell" {
    script = "../shared/scripts/upgrade"
  }

  provisioner "shell" {
    script = "../shared/scripts/kernel_config"
  }

  provisioner "shell" {
    environment_vars = [
      "DB_TOOLS_VERSION=${var.db_tools_version}"
    ]
    script = "./scripts/initial_download"
  }

  provisioner "shell" {
    script = "./scripts/install_automation_agent"
  }

  provisioner "shell" {
    script = "../shared/scripts/cleanup"
  }

}