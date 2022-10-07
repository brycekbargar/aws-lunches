terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "aws-lunch-tf"
  default_tags {
    tags = {
      terraform = "true"
      source    = "aws-lunches"
      chapter   = "one"
    }
  }
}
