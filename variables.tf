variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "name" {
    type = string
    default = "my-vpc"
}

variable "key" {
  type = string
  default = ""
}

variable "secret" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "public_subnet" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_1" = 2
    "public_subnet_1" = 3
  }
}


variable "private_subnet" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_1" = 2
    "private_subnet_1" = 3
  }
}

variable "environment" {
  type = string
  description = "dev"
}

variable "variable-sub_az" {
   type        = string
   default     = "ap-east-1a"
   description = "AZ for SEA "
}