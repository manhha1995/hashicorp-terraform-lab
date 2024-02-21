terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws",
        version = "~> 4.16"
    }
  }
}

data "aws_availability_zone" "available" {}

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
    Region = data.aws_region.current.name
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

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gatewau_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    name = "igw"
  }
}

resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

locals {
  ingress_rules = [{
    port = 443
    description = "Port 443"
  },
  {
    port = 80
    description = "Port 80"
  }
  ]
}

resource "aws_security_group" "security_groups" {
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
  }
}

module "vpc" {
  source = "./modules/vpc"
  subnet_id = ""
  security_groups = ""
  size = ""
  ami = ""
}
