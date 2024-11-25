output "storage_account_name" {
  value = "${var.storage_account_name}${random_string.unique_suffix.result}"
}

output "app_service_name" {
  value = "${var.app_service_name}${random_string.unique_suffix.result}"
}

output "name" {
  value = "${var.name}${random_string.unique_suffix.result}"
}