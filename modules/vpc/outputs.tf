output "vpc_id" {
  value = aws_instance.web.public_ip
}

output "size" {
  value = aws_instance.web.instance_type
}

output "subnet_id" {
  value = aws_instance.web.subnet_id
}