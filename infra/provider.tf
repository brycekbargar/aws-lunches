terraform {
  required_version = ">=1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  profile = "aws-lunch-tf"
  default_tags {
    tags = {
      terraform = "true"
      source    = "aws-lunches"
      chapter   = "three"
    }
  }
}
