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

variable "docker_registry_password" {
  description = "The Docker registry password"
  type        = string
  sensitive   = true
}

variable "docker_image" {
  description = "The Docker image. Should always be latest"
  type        = string
}

variable "docker_registry_url" {
  description = "The Docker registry URL"
  type        = string

}
variable "docker_registry_username" {
  description = "The Docker registry username"
  type        = string
  sensitive   = true
}

variable "storage_url" {
  description = "The blob storage URL"
  type        = string
}

variable "storage_account_id" {
  description = "The storage account ID"
  type        = string
}

variable "database_host" {
  description = "The database host"
  type        = string
}

variable "database_name" {
  description = "The database name"
  type        = string
}

variable "database_user" {
  description = "The database user"
  type        = string
}

variable "database_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}
