resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  force_destroy = true
  
  tags = {
    Name        = "MyFirstBucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2 Security Group"
  }
}
resource "aws_key_pair" "ec2_key" {
  key_name   = "sravya-key"
  public_key = file("~/.ssh/sravya-key.pub")
}
resource "aws_instance" "web_server" {
  ami           = "ami-0d4596c0733abc100" # Amazon Linux 2 AMI for us-east-2
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  user_data =<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd unzip aws-cli
              sudo systemctl start httpd
              sudo systemctl enable httpd
              cd /var/www/html
              aws s3 cp s3://sravya-auto-provision-bucket/Ramayanam.zip .
              unzip Ramayanam.zip
              rm -f Ramayanam.zip
            EOF

  tags = {
    Name = "Sravya-EC2-Instance"
  }
}
