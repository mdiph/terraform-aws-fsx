terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

resource "aws_fsx_ontap_file_system" "fsadg" { # sesuain
  storage_capacity                = var.fs_capacity
  subnet_ids                      = var.subnet_ids
  deployment_type                 = "MULTI_AZ_1"
  preferred_subnet_id             = var.subnet_ids[0]
  endpoint_ip_address_range       = var.endpoint_ip_address_range
  fsx_admin_password              = var.fsxadmin_password
  tags = {
    Name      = "fsadg" # disesuaiin
    Terraform = "True" #
    Owner     = "allianz" #
  }
}

resource "aws_fsx_ontap_storage_virtual_machine" "svm_adg" { # sesuaiin
  file_system_id = aws_fsx_ontap_file_system.fsadg.id
  name           = var.svm_name
}

resource "aws_fsx_ontap_volume" "vol_adg01" {
  name                       = "vol_adg01"
  size_in_megabytes          = 15728640 # 15tb
  storage_efficiency_enabled = true
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm_adg.id
}