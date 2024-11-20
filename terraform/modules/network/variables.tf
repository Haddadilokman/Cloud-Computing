variable "vnet_name" {}
variable "address_space" {
  type = list(string)
}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_name" {}
variable "subnet_address_prefixes" {
  type = list(string)
}
