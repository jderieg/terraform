variable "vpc_id" {}
variable "vpc_name" {}
variable "sshproxy_id" {}
variable "all_cidrs" {
  type = "list"
}
variable "all_vpn_endpoints" {
  type = "list"
}
variable "ULOregon_natgws" {
  type = "list"
}
variable "sandyofficeandlab" {
  type = "list"
}
variable "azureproxylbs" {
  type = "list"
}
variable "atlaspeers" {
  type = "list"
}
variable "azure_subnets" {
  type = "list"
}