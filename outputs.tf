output "security_group_id" {
  value = aws_security_group.ec2_sg.id
}
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}
