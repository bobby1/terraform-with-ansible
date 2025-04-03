###======================================================================================
### Copyright (c) 2023, Bobby Wen, All Rights Reserved 
### Use of this source code is governed by a MIT-style
### license that can be found at https://en.wikipedia.org/wiki/MIT_License.
### Project:		Cloud Software Group challenge
### Class:			Terraform AWS IaC file
### Purpose:    Terraform script to create servers instances 
### Usage:			terraform (init|plan|apply|destroy)
### Pre-requisits:	AWS access configuration(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), 
###                 Terraform by HashiCorp (https://www.terraform.io/)
### Beware:     Variables.tf file is used to pass environment variable to main.tf.  
###             Depending on SDLC environmental setting, different attributes are passed to create the stack 
###
### Developer: 	Bobby Wen, bobby@wen.org
### Creation date:	20230913_0946
###======================================================================================
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# provider "aws" {
#   region = var.aws_region
# }

# resource "null_resource" "check_and_create_backend" {
#   provisioner "local-exec" {
#     command = <<EOT
#       aws s3api head-bucket --bucket b1dev-terraform-state || aws s3api create-bucket --bucket b1dev-terraform-state --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1
#       aws dynamodb describe-table --table-name devops-ecs-terraform-locking || aws dynamodb create-table --table-name devops-ecs-terraform-locking --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
#     EOT
#   }
# }
# provider "aws" {
#   region = var.aws_region
# }

provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "b1dev-terraform-state"
    key            = "dev/ecs/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "devops-ecs-terraform-locking"
    encrypt        = true
  }
}



resource "aws_instance" "ec2_instance" {
  ami                    = var.aws_instance_id[var.aws_region]
  instance_type          = var.aws_instance_type[var.environment]
  key_name               = var.aws_key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    project     = var.project_name
    environment = var.environment
    name        = var.instance_name
  }
  count = var.instance_count[var.environment]
}

resource "aws_key_pair" "deployer" {
  key_name = var.aws_key_name
  ### There are many ways of securing secret information, including using a secrets.tfvars file, environmental variables and key management systems.  ### DEBUG
  ### This example reads files outside of the code base, and the files are not checked in as part of the code.  ### DEBUG
  ### This allow individual developers to use their own key pair.  ### DEBUG
  public_key = file("../../../myaws_private_key.txt")
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("../../../test_rsa.pem")
    timeout     = "4m"
  }
}

resource "aws_security_group" "main" {
  egress {
    description      = "Cidr Blocks and ports for Egress security"
    cidr_blocks      = var.egress_cidr_blocks[var.environment]
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }

  ingress {
    description      = "Cidr Blocks and ports for Ingress security"
    cidr_blocks      = var.ingress_cidr_blocks[var.environment]
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }

  ingress {
    description      = "Cidr Blocks and ports for Ingress security"
    cidr_blocks      = var.ingress_cidr_blocks[var.environment]
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
  }

}
