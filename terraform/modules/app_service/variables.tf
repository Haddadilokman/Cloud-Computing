variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {
  description = "The ID of the subnet for App Service"
}
# Database configuration
variable "database_port" {
  default = "5432"
}
