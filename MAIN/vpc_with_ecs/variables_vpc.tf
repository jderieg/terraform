# VPC Variables
variable "vpc_name" {
  description = "VPC Name"
}

variable "region" {
  description = "Region you want to build your infrastructure in"
}

variable "aws_profile" {
  description = "Name of aws profile to use in ~/.aws/credentials file"
}

variable "vpc_cidr" {
  description = "VPC CIDR address before broken down into subnets"
}

variable "az_list" {
  type = list
  description = "List of aws AZ's you want to use"
}

variable "privsub_list" {
  type = list
  description = "List of Private Subnet CIDR's"
}

variable "pubsub_list" {
  type = list
  description = "List of Public Subnet CIDR's"
}

variable "pub_ipv6_prefixlist" {
  type = list
  description = "List of Private Subnet CIDR's"
}

variable "priv_ipv6_prefixlist" {
  type = list
  description = "List of IPv6 prefixes for IPv6 creation"
}

variable "environment_tag" {
  description = "The environment being deployed - e.g. 'dev', 'stage', etc."
}