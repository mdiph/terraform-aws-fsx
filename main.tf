# Create FSxN file system, SVM, volume
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region  = "ap-southeast-3"
  default_tags {
    tags = {
      Deployment-Type = "Terraform"
      Date            = "14-May-2025"
    }
  }
}


resource "random_password" "fsxn_fs_admin_password" {
  length           = 12
  number           = true
  special          = true
  override_special = "!"
}

data "aws_secretsmanager_secret_version" "creds" {
  # Fill with the secret password
  secret_id = "secretpassword"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

# FSxN - File System

resource "aws_fsx_ontap_file_system" "terraform_fsxn" {
  storage_capacity    = var.storage_capacity
  subnet_ids          = var.subnet_ids
  deployment_type     = var.deployment_type
  preferred_subnet_id = var.preferred_subnet_id
  throughput_capacity = var.throughput_capacity
  fsx_admin_password  = random_string.fsxn_fs_admin_password.result
  kms_key_id          = var.kms_key_id
}

# FSxN - Storage Virtual Machine (SVM)

resource "aws_fsx_ontap_storage_virtual_machine" "fsxn_svm" {
  file_system_id = aws_fsx_ontap_file_system.terraform_fsxn.id
  name           = var.svmname
  active_directory_configuration {
    netbios_name = "terraform-svm"
    self_managed_active_directory_configuration {
      dns_ips                                = var.dns_ips
      domain_name                            = "EXAMPLE.COM"
      organizational_unit_distinguished_name = var.OrganizationalUnitDistinguishedName
      username                               = local.db_creds.admin
      password                               = local.db_creds.password
    }
  }
}

# FSX for ONTAP - Volume

resource "aws_fsx_ontap_volume" "fsxn_vol" {
  name                       = var.volname
  junction_path              = "/${var.volname}"
  security_style             = var.security_style
  size_in_megabytes          = var.size_in_megabytes
  storage_efficiency_enabled = var.storage_efficiency_enabled
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.fsxn_svm.id

  tiering_policy {
    name = var.tiering_policy_name
  }
}