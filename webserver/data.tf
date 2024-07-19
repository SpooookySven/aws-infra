data "terraform_remote_state" "vpc-network" {
  backend = "s3"
  config = {
    bucket = var.vpc_network_bucket 
    region = var.vpc_network_region
    key = var.vpc_network_key
  }
}

data "aws_acm_certificate" "sven-herrmann-lb" {
  domain   = "sven-herrmann.com"
  statuses = ["ISSUED"]
}

