# Terraform-hosted-website-on-aws
This repository contains a Terraform-based project that automatically provisions AWS infrastructure to host a static website. The setup includes S3 for object storage, EC2 for web hosting, IAM Roles for permission handling, and Security Groups for traffic control. This project demonstrates a practical use of Infrastructure as Code (IaC) to deploy a fully functioning website, accessible via a public IP address.


# Model Description

The project utilizes Terraform to automate the deployment of a static website on AWS. It creates and configures all necessary resources, including an S3 bucket for storing the website archive, an EC2 instance to host the Apache web server, and IAM roles to enable EC2 access to S3.

A zipped static website (built using HTML, CSS, and JavaScript) is pulled from the S3 bucket by the EC2 instance during initialization and served through Apache HTTP Server. This end-to-end infrastructure deployment showcases the power of Terraform in automating real-world cloud solutions.

# Key features of the project:

• Automates full AWS infrastructure provisioning using Terraform.

• Hosts a static website using EC2 with Apache HTTP Server.

• Fetches zipped website files from an S3 bucket and unpacks them into /var/www/html.

• Applies IAM Role-based access to allow EC2 to read from S3 securely.

• Implements Security Groups to allow HTTP and SSH access.

• Uses user data scripts to bootstrap the EC2 instance with the necessary packages.


# Replication Steps

To replicate the steps and deploy your own static website using this Terraform project, please follow the instructions below:

1. Website Preparation
Create your static website using HTML, CSS, and JavaScript. Zip the entire website folder (ensure it includes an index.html file as the homepage). Name the zip file appropriately, for example: Ramayanam.zip.

2. Environment Setup
Install the following tools on your local machine:

      • Terraform

      • AWS CLI

Then, configure AWS CLI with your credentials by running:
aws configure
Provide your Access Key, Secret Key, region (e.g., us-east-2), and preferred output format (e.g., JSON).

3. Upload the Website to S3
After your S3 bucket is created by Terraform, upload the zipped website using:
aws s3 cp Ramayanam.zip s3://your-bucket-name/

4. Initialize the Terraform Project
Clone or download this GitHub repository. Navigate into the project directory and run:
terraform init

This will initialize the Terraform working directory and download the necessary provider plugins.

5. Set Your Variables
Make sure the following variables are correctly set in a file like terraform. tfvars:

      • region = "us-east-2"

      • bucket_name = "your-bucket-name"

      • instance_type = "t2.micro"

      • key_name = "your-key-pair-name"

6. Run the Terraform Plan and Apply
To preview the infrastructure that will be created, run:
terraform plan
Then, to actually provision the infrastructure, run:
terraform apply
Type yes when prompted to approve the changes.

7. Access the Website
Once Terraform finishes applying, it will output the public IP of the EC2 instance. Open your browser and visit:
http://<your-ec2-public-ip>
You should now see your static website live.
