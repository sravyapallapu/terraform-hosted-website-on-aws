# IAM Role: Allows EC2 to assume a role
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach the AmazonS3ReadOnlyAccess managed policy to the role
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Create instance profile to associate the IAM role with EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}
