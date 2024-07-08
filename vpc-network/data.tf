data "aws_acm_certificate" "server" {
  domain   = "server"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "sven_herrmann_tld" {
  domain   = "sven.herrmann.tld"
  statuses = ["ISSUED"]
}

