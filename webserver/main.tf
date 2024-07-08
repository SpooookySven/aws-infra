provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket         = "tf-state-magrathea"
    dynamodb_table = "tf-state-magrathea"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "eu-west-1" 
  }
}
