variable "vpc_name" {}

variable "region" {}

variable "vpc_cidr" {}

variable "az_list" {
  type = list
}

variable "privsub_list" {
  type = list
}

variable "pubsub_list" {
  type = list
}

variable "pub_ipv6_prefixlist" {
  type = list
}

variable "priv_ipv6_prefixlist" {
  type = list
}

variable "environment_tag" {}