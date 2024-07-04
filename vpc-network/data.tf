data "aws_acm_certificate" "sven_herrmann_com" {
  domain   = "sven-herrmann.com"
  statuses = ["ISSUED"]
}
