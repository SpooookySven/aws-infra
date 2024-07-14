module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.name}-${var.environment}-vpc"

  cidr = "${var.cidr}" 
  private_subnets = "${var.private_subnets}" 
  public_subnets  = "${var.public_subnets}" 

  enable_nat_gateway = "true"

  azs      = "${var.azs}" 

  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
  }
}
