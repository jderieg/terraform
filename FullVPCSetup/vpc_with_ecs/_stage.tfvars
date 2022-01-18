##### VPC App Vars
vpc_name             = "stage_vpc"
region               = "us-east-1"
vpc_cidr             = "10.2.0.0/20"
az_list              = ["us-east-1a", "us-east-1b", "us-east-1c"]
pubsub_list          = ["10.2.0.0/24", "10.2.2.0/24", "10.2.3.0/24"]
privsub_list         = ["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
pub_ipv6_prefixlist  = [0, 1, 2]
priv_ipv6_prefixlist = [3, 4, 5]
environment_tag      = "stage"
aws_profile          = "default" # Your aws profile in the ~/.aws/credentials file

##### Docker App Vars
app_name             = "jdapp-stage" # Do not enter any spaces
app_sources_cidr     = ["191.101.61.197/32"] # Specify a list of IPv4 IPs/CIDRs which can access app load balancers
docker_app_image     = "elastichq/elasticsearch-hq:latest"
docker_app_name      = "elastichq" # Whatever you want to call it
docker_app_port      = 5000 # Port that your docker app is expecting connection on - keep unquoted or json will fail decoding
alb_frontend_port    = "80"