variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "name" {
  type = string
}
variable "cidr" {
  type = string
}
variable "private_subnets" {
  type = list(string) 
}
variable "public_subnets" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "dns_servers" {
  type = list(string)
}
