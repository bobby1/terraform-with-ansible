###======================================================================================
### Copyright (c) 2023, Bobby Wen, All Rights Reserved 
### Use of this source code is governed by a MIT-style
### license that can be found at https://en.wikipedia.org/wiki/MIT_License.
### Project:		Cloud Software Group challenge
### Class:			Terraform AWS variable file
### Purpose:    Variables file Terraform script to create servers instances based on environment
### Usage:			terraform, used by terraform main.tf
### Pre-requisits:	AWS access configuration(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), 
###                 Terraform by HashiCorp (https://www.terraform.io/)
### Beware:     Variables.tf file is used to pass environment variable to main.tf.  
###             Depending on SDLC environmental setting, different attributes are passed to create the stack 
###
### Developer: 		Bobby Wen, bobby@wen.org
### Creation date:	20230913_1723
###======================================================================================

variable "project_name" {
  description = "product or project name"
  type        = string
  default     = "Core tools team"
}

variable "environment" {
  description = "SDLC Infrastructure environment: THIS SETS THE DEPLOYMENT ENVIRONMENT"
  type        = string
  default     = "stg"
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "aws_instance_id" {
  description = "AWS machine Image ID for deployment"
  type        = map(string)
  default = {
    us-east-1 = "ami-0261755bbcb8c4a84"
    us-east-2 = "ami-0430580de6244e02e"
    us-west-1 = "ami-04d1dcfb793f6fa37"
    us-west-2 = "ami-0c65adc9a5c1b5d7c"
  }
}

variable "aws_instance_type" {
  description = "EC2 instance type"
  type        = map(string)
  default = {
    dev = "t2.micro"
    stg = "t2.medium"
    prd = "t2.large"
  }
}

variable "aws_key_name" {
  description = "preconfigured key name"
  type        = string
  default     = "aws_key"
}

variable "aws_public_key" {
  description = "pre-configured public key to use in instance"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgS5WqlNu2AojxJE/9c8BmhlZIc8EXz0qszhp6kzsaVVkkGK3Gl6o1DtQrrlyoolkc3Zrgw1jPI91n/wz69p4Yz6ND8HCGdz/VCdhCJfv6cW330B2IiWc8emQJ3We6gZhjzZAegAQh2DsLWGJlXGFySk6Y3LFxsdovrFwHlWK6jZ5kYOETSq5wugDKQVf4RSbVhh2/rnmKO/ur+lo31+Crqx2d8oV0KQcItLG8iR1aX0NJTWxGGBHxVSxQIVz9WXWUlclz3Og7oAXjzKTs70geyqYsowGHLWL+ruIrT4tIqVyTDySl+Aaas6hdx7+rGs2qKZgQoS1dZqXRKw/smALSAeUoYqcg98ZfSP48LLDa+IZaCGzqvwq+xJg9OUEivrwsikfxMP/ZjCLrFuspNH5v1XEcyGQXDpQkfrQRoGLiVvsymGiXcOHcMrML/fRtLXzy7lk+bf6a6eC+wiLKDikYcvVipszFCFYzN3PqOdcRVY18u6c4IvNG+Vy0wjmHR70= bobby@wen.org"
  sensitive   = true
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = map(number)
  default = {
    dev = 2
    stg = 4
    prd = 6
  }
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks to allow in the security group"
  type        = map(list(string))
  default = {
    ### 67.174.209.57/32 is bobby's home IP address DEBUG
    # dev = ["67.174.209.57/32", ]          ### DEBUG
    dev = ["0.0.0.0/0", ]
    ### 54.86.126.30/24 is cloud.com's IP address  ### DEBUG
    stg = ["54.86.126.30/24", ]
    prd = ["0.0.0.0/0", ]
  }
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks to allow in the security group"
  type        = map(list(string))
  default = {
    ### 67.174.209.57/32 is bobby's home IP address   ### DEBUG
    # dev = ["67.174.209.57/32", ]              ### DEBUG
    dev = ["0.0.0.0/0", ]
    stg = ["0.0.0.0/0", ]
    prd = ["0.0.0.0/0", ]
  }
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "CoreToolsTestInstance"
}