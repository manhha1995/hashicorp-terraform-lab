variable "ami" {}
variable "size" {
    default = "t2.micro"
}
variable "security_groups" {
  type = list(any)
}

variable "subnet_id" {
}
