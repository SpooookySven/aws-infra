resource "aws_route53_zone" "private" {
  name = "sven-herrmann.com"

  vpc {
    vpc_id = module.vpc.vpc_id 
  }
}
