# FSxN Output Values

output "fsxn_arn" {
  value = aws_fsx_ontap_file_system.terraform_fsxn.id
}

output "fsxn_dns_name" {
  value = aws_fsx_ontap_file_system.terraform_fsxn.dns_name
}

output "fsxn_endpoints" {
  value = aws_fsx_ontap_file_system.terraform_fsxn.endpoints
}

output "svm_id" {
  value = aws_fsx_ontap_storage_virtual_machine.fsxn_svm.id
}