variable "aws_region" {
  description = "Region in AWS"
  type        = string
}

variable "fs_capacity" {
  description = "Capacity in Gib for filesystem"
  type        = number
}


variable "fsxadmin_password" {
  description = "ONTAP administrative password fsxadmin user"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "Array of subnet ids"
  type        = list(string)
}

variable "endpoint_ip_address_range" {
  description = "Floating IP CIDR for the filesystem"
  type        = string
}

variable "svm_name" {
  description = "Name of svm"
  type        = string
}