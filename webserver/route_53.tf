resource "aws_route53_record" "magrathea" {
  zone_id = "${data.terraform_remote_state.vpc-network.outputs.zone_id}" 
  name    = "magrathea.sven-herrmann.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.magrathea.private_ip]
}
