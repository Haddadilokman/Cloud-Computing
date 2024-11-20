variable "server_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "admin_login" {}
variable "admin_password" {}
variable "sku_name" {}
variable "storage_mb" {}
variable "subnet_id" {}
variable "database_name" {}
variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to associate with the PostgreSQL Flexible Server."
}
variable "name" {
  description = "The name of the PostgreSQL Flexible Server."
}
variable "storage_tier" {}