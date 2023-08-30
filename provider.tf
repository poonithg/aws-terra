terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    region  = "us-east-1"
    key     = "terraformstatefile"
    bucket  = "terraform-state-demo-001xxx"
    profile = "demo"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "demo"
}
