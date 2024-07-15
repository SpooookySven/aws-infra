output "zone_id" {
  value = aws_route53_zone.private.zone_id
}
output "zone_arn" {
  value = aws_route53_zone.private.arn
}
output "pub_rt_id" {
  value = module.vpc.public_route_table_ids
}

output "public_subnet_ids" {
	value = module.vpc.public_subnets
}
output "private_subnet_ids" {
    value = module.vpc.private_subnets
}

