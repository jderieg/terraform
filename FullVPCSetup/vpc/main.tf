module "new_vpc" {
  source = "../pub_modules/terraform-aws-vpc/"
  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.az_list
  private_subnets = var.privsub_list
  public_subnets  = var.pubsub_list

  enable_ipv6                     = true
  assign_ipv6_address_on_creation = true

  private_subnet_assign_ipv6_address_on_creation = false

  public_subnet_ipv6_prefixes   = var.pub_ipv6_prefixlist
  private_subnet_ipv6_prefixes  = var.priv_ipv6_prefixlist

  enable_nat_gateway = true
  enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = {
    Terraform = "true"
    Environment = var.environment_tag
  }
}