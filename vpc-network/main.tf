provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket         = "tf-state-vpc-network"
    dynamodb_table = "tf-state-vpc-network"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "eu-west-1" 
  }
}
