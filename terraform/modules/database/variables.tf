variable "server_name" {
  description = "The name of the PostgreSQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the PostgreSQL Flexible Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure location/region where the resources will be deployed (e.g., West Europe, East US)."
  type        = string
}

variable "admin_login" {
  description = "The administrator login for the PostgreSQL Flexible Server."
  type        = string
}

variable "admin_password" {
  description = "The administrator password for the PostgreSQL Flexible Server."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU of the PostgreSQL Flexible Server (e.g., B_Standard_B1ms, GP_Standard_D2s_v3)."
  type        = string
}

variable "storage_mb" {
  description = "The storage size in megabytes for the PostgreSQL Flexible Server."
  type        = number
}

variable "subnet_id" {
  description = "The ID of the delegated subnet for the PostgreSQL Flexible Server."
  type        = string
}

variable "database_name" {
  description = "The name of the initial database to create on the PostgreSQL Flexible Server."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to associate with the PostgreSQL Flexible Server."
  type        = string
}

variable "name" {
  description = "The friendly name of the PostgreSQL Flexible Server."
  type        = string
}