###======================================================================================
### Copyright (c) 2023, Bobby Wen, All Rights Reserved 
### Use of this source code is governed by a MIT-style
### license that can be found at https://en.wikipedia.org/wiki/MIT_License.
### Project:		Cloud Software Group challenge
### Class:			Terraform AWS output file
### Purpose:    Ouput information collected from Terraform creation of servers instances 
### Usage:			terraform, used by terraform main.tf
### Pre-requisits:	AWS access configuration(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), 
###                 Terraform by HashiCorp (https://www.terraform.io/)
### Beware:     Variables.tf file is used to pass environment variable to main.tf.  
###             Depending on SDLC environmental setting, different attributes are passed to create the stack 
###
### Developer: 		Bobby Wen, bobby@wen.org
### Creation date:	20230913_0946
###======================================================================================
output "deployment_region" {
  description = "Region name of the deployment"
  value       = var.aws_region
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2_instance[*].id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance[*].public_ip
}

output "instance_public_dns_name" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.ec2_instance[*].public_dns
}