#output "ZoneID" {
#  value = module.zones.route53_zone_zone_id
#}
#output "ZoneName" {
#  value = module.zones.route53_zone_name
#}
#output "ZoneNameStatic" {
#  value = module.zones.route53_static_zone_name
#}
#output "ZoneARN" {
#  value = module.zones.route53_zone_zone_arn
#}
output "pub_rt_id" {
  value = module.vpc.public_route_table_ids
}

output "public_subnet_ids" {
	value = module.vpc.public_subnets
}
output "privatesubnet_ids" {
    value = module.vpc.private_subnets
}

