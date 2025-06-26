variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
