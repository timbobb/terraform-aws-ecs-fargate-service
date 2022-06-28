module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.13"
  name_prefix                                 = "base"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19"]
}

module "load_balancer" {
  source          = "../../"
  name_prefix     = "test-alb"
  vpc_id          = module.base-network.vpc_id
  private_subnets = module.base-network.private_subnets_ids
  public_subnets  = module.base-network.public_subnets_ids
}
