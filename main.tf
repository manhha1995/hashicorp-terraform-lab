terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws",
        version = "~> 4.16"
    }
  }
}

# data "aws_availability_zone" "available" {}

data "aws_region" "current" {}

locals {
  team = "api_mgmt_dev" 
  application = "e-commerce"
  server = "ec2-${var.environment}-ecm-${var.variable-sub_az}"
}
provider "aws" {
  region = "ap-southeast-1"
  access_key = var.key
  secret_key = var.secret
  
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    name = var.name
    environment = "dev"
    terraform = "true"
  }
}

resource "aws_subnet" "public_subnet" {
 for_each = var.public_subnet
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, each.value)
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnet
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, each.value)
  availability_zone = "ap-southeast-1b"
}