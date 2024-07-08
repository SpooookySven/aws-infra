resource "aws_ec2_client_vpn_endpoint" "milliways" {
  description            = "terraform-clientvpn"
  server_certificate_arn = data.aws_acm_certificate.server.arn
  client_cidr_block      = "10.2.0.0/22"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.server.arn 
  }

  connection_log_options {
    enabled               = false
  }
}

resource "aws_ec2_client_vpn_network_association" "vpn_net_conn_priv" {
	client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.milliways.id
	for_each			   = {
    for index, subnetID in module.vpc.private_subnets : "private-${module.vpc.azs[index]}" => subnetID
  }
	subnet_id              = each.value
}

