variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the App Service"
  type        = string
}

# Database configuration
variable "database_port" {
  description = "The port on which the database server listens (default is 5432 for PostgreSQL)"
  type        = number
  default     = 5432
}
