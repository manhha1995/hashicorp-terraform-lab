resource "aws_instance" "web" {
   ami = var.ami
}