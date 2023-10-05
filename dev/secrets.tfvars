###======================================================================================
### Copyright (c) 2023, Bobby Wen, All Rights Reserved 
### Use of this source code is governed by a MIT-style
### license that can be found at https://en.wikipedia.org/wiki/MIT_License.
### Project:		Cloud Software Group challenge
### Class:			Terraform AWS variable file
### Purpose:    Variables file for secrets and local variables
### Usage:			terraform, used by terraform main.tf
### Pre-requisits:	AWS access configuration(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html), 
###                 Terraform by HashiCorp (https://www.terraform.io/)
### Beware:     secrets.tfvars file is used to pass environment variable to main.tf.  
###             Depending on SDLC environmental setting, different attributes are passed to create the stack 
###
### Developer: 		Bobby Wen, bobby@wen.org
### Creation date:	20231005_1503
###======================================================================================
### ssh key to connect to instances  It should be something like   "ssh-rsa AAAA......HR70= your_email_address"
aws_public_key = <change to your ssh key>

