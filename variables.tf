# FSX for ONTAP - File System Variables

variable "FSxNName" {
  description = "fsxn filesystem name"
  type        = string
  default     = "BlogFSxN"
}

variable "deployment_type" {
  description = "filesystem deployment type (SINGLE_AZ_1 or MULTI_AZ_1)"
  type        = string
  default     = "MULTI_AZ_1"
}

variable "subnet_ids" {
  description = "list of subnet IDs where vpc endpoints will be placed (1 or 2 list items depending on deployment_type var)"
  type        = list(any)
  default     = ["subnet-65523503", "subnet-8c9ec782"]
}

variable "preferred_subnet_id" {
  description = "subenet were primary instance will reside"
  type        = string
  default     = "subnet-65523503"
}

variable "route_table_ids" {
  description = "**ONLY APPLIES TO MULTI AZ DEPLOYMENTS** the VPC route tables in which the file system's endpoints will be created - defaults to default route table when null"
  type        = list(any)
  default     = null
}

variable "security_group_ids" {
  description = "A list of IDs for the security groups that apply to the specified network interfaces created for file system access. These security groups will apply to all network interfaces. Defaults to default security group when null"
  type        = list(any)
  default     = null
}

variable "storage_capacity" {
  description = "storage capacity in GiB of the file system. Valid values between 1024 and 196608"
  type        = number
  default     = 1024
}

variable "throughput_capacity" {
  description = "Sets the throughput capacity (in MBps) for the file system that you're creating. Valid values are 128, 256, 512, 1024, 2048 and 4096"
  type        = number
  default     = 128
}

variable "kms_key_id" {
  description = "ARN for the KMS Key to encrypt the file system at rest - if null defaults to an AWS managed KMS Key."
  type        = string
  default     = null
}

# FSxN - SVM Variables

variable "svmname" {
  description = "The name of the SVM. You can use a maximum of 47 alphanumeric characters, plus the underscore (_) special character."
  type        = string
  default     = "blog-svm"
}

variable "netbios_name" {
  type    = string
  default = "blog-svm"
}

variable "dns_ips" {
  type    = list(string)
  default = ["172.31.76.144", "172.31.8.8"]
}

variable "domain_name" {
  description = "Domain Name of the ActiveDirectoryConfiguration"
  default     = "example.com"
}

variable "OrganizationalUnitDistinguishedName" {
  description = "Organization unit for FSxN"
  default     = "OU=computers,OU=corp,DC=corp,DC=example,DC=com"

}

variable "RootVolumeSecurityStyle" {
  description = "Security Style of the Root volume"
  default     = "Unix"
}

# FSxN - Volume variables
variable "volname" {
  description = "The name of the Volume. You can use a maximum of 203 alphanumeric characters, plus the underscore (_) special character"
  type        = string
  default     = "volume1"
}

variable "junction_path" {
  description = "Specifies the location in the storage virtual machine's namespace where the volume is mounted. The junction_path must have a leading forward slash, such as /vol3"
  type        = string
  default     = "/volname"
}

variable "security_style" {
  description = "Specifies the volume security style, Valid values are UNIX, NTFS, and MIXED"
  type        = string
  default     = "UNIX"
}

variable "size_in_megabytes" {
  description = "Specifies the size of the volume, in megabytes (MB), that you are creating."
  type        = string
  default     = "10240"
}

variable "storage_efficiency_enabled" {
  description = "Set to true to enable deduplication, compression, and compaction storage efficiency features on the volume."
  type        = string
  default     = "true"
}

variable "tiering_policy_name" {
  description = "Specifies the tiering policy for the ONTAP volume for moving data to the capacity pool storage. Valid values are SNAPSHOT_ONLY, AUTO, ALL, NONE"
  type        = string
  default     = "AUTO"
}