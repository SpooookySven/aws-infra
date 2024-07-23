resource "aws_ec2_client_vpn_endpoint" "milliways" {
  description            = "terraform-clientvpn"
  server_certificate_arn = data.aws_acm_certificate.server.arn
  client_cidr_block      = "10.2.0.0/22"
  dns_servers = var.dns_servers
  
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = data.aws_acm_certificate.server.arn 
  }

  connection_log_options {
    enabled               = false
  }
  tags = {
    Name = var.name
  }

}

resource "aws_ec2_client_vpn_network_association" "vpn_net_conn_pub" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.milliways.id
  for_each			   = {
  for index, subnetID in module.vpc.public_subnets : "private-${module.vpc.azs[index]}" => subnetID
  }
  subnet_id              = each.value
  timeouts {
    create = "30m"
    delete = "30m"
  }
}

resource "aws_ec2_client_vpn_route" "milliways_routing" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.milliways.id
  destination_cidr_block = "0.0.0.0/0"
  for_each               = {
    for index, subnetID in module.vpc.public_subnets : "private-${module.vpc.azs[index]}" => subnetID
  }
  target_vpc_subnet_id   = each.value
  timeouts {
    create = "10m"
    delete = "10m"
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "milliways_cidr_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.milliways.id
  target_network_cidr    = var.cidr
  authorize_all_groups   = true
  timeouts {
    create = "10m"
    delete = "10m"
  }
}

resource "aws_ec2_client_vpn_authorization_rule" "milliways_internet_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.milliways.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
  timeouts {
    create = "10m"
    delete = "10m"
  }
}

