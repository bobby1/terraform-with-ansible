# terraform-with-ansible
This code is a basic demonstration of ways to create Structured Design Life Cycle (SDLC) deployment cloud environments with minimum effort.  The code uses terraform to create an Amazon Web Services (AWS).  Then Ansible is used to push basic tools and configuration to the new server instances and install a security agent.

## Design Principles
* Reusable code: The same code base is used for all environment, implementation differences are set based on the environment or tier for the SDLC.
* SDLC from the start: Development (dev), Staging (stg) and Production (prd) folders are available to allow checkout of the code to implement a project using all basic tiers at the beginning of a project.
* Scalable:  the environment setting allows each environment to scale automatically.  Development environment use micro server instance (t2.micro) to service a small number of developers, staging environments uses medium server instances (t2.medium) to allow a large audience to test the application.  Production environments uses large server instances (t2.large) to be generally available to the Internet.

  ** In the same manner, dev environments will create two server instances.  Stg environments will create four server instances.  And Prd environments will create six server instances automatically

* Secure: The code show examples of how to secure user account and application accessiblity based on environments.
  
  ** Secure Shell Protocol (SSH) keys can be pre-configured and installed on the server to allow secure sessions with the all the server instances.
  
  ** Access to the server instances are limited based on the environment.  Dev can be configured to only allow developer access.  Stg can be configured to only allow corporate user access.  Prd can be configured to allow general Internet access.

* Flexible: The code can be customized for individual environments, based on your application needs, for example.  the AWS Machine Images (ami) for each region can be preconfigure, without the need to have project specify them for every region. Additional configuration parameters are already in the code to allow for easy customization.
  
* Auditable: The code create output and logging where possible.
  ** The public IP and DNS name for servers instances created are output in Terraform to allow easy access to the new instance

  ** Scripts on servers create a local trail of activity as well as log to the syslog or remote syslogger.

* Easy to use:  All code contains a banner with project, usage, pre-requisit and beware sections.  In addition, tags to identify the project, environment and other identifable information are added where possible.

## Pre-requisits

To use this code base, AWS, Terraform and Ansible are required to be installed locally on the server.

   AWS access configuration(https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  
   Terraform by HashiCorp (https://www.terraform.io/)
  
    Ansible (https://www.ansible.com/)

An OpenSSH key-pair must be available to upload with the new environment

## How to use

* To create the example environment,  in the SDLC directory for the environment to deploy, for example, dev

  $ terraform init

  $ terrafrom fmt

  $ terraform validate

  $ terraform plan

  $ terraform apply
  
 Once the server instance are created, Terraform will output the server name and IP.  You can retrieve this output at any time after creating the instances by running 
  
  $ terraform output
  
Once you have the new instance DNS name information, connect to each instance to ensure your connection and ssh keys work.

for example:  
  $  ssh ubuntu@ec2-54-92-22-20.compute-1.amazonaws.com and accept the server ssh key into the ssh known-hosts
    or
  $  ssh -o StrictHostKeyChecking=accept-new  ubuntu@ec2-54-92-222-205.compute-1.amazonaws.com to automatically accept the ssh key

