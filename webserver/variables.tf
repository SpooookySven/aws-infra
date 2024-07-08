variable "region" {
  type = string
}
variable "environment" {
  type = string
}
variable "name" {
  type = string
}
variable "private_subnets" {
  type = list(string) 
  default = []
}
variable "public_subnets" {
  type = list(string)
  default = []
}
variable "vpc_network_bucket"{
  type = string
}
variable "vpc_network_key"{
  type = string
}
variable "vpc_network_region"{
  type = string
}

