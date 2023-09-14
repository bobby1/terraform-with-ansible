# terraform-with-ansible
This code is a basic demonstration of ways to create Structured Design Life Cycle (SDLC) deployment cloud environments with minimum effort.  The code uses terraform to create Amazon Web Services (AWS) instances.  And, Ansible is used to push basic tools and configuration to the new server instances and install a security agent.

## Design Principles
* Reusable code: The same code base is used for all environment; implementation differences are set based on the environment or tier for the SDLC.
* SDLC from the start: Development (dev), Staging (stg) and Production (prd) folders are available to allow checkout of the code to implement a project using all basic tiers at the beginning of a project.
* Scalable:  the environment setting allows each environment to scale automatically.  Development environment use micro server instance (t2.micro) to service a small number of developers, staging environments uses medium server instances (t2.medium) to allow a large audience to test the application.  Production environments uses large server instances (t2.large) to be generally available to the Internet.

  ** In the same manner, dev environments will create two server instances.  Stg environments will create four server instances.  And Prd environments will create six server instances automatically

* Secure: The code show examples of how to secure user account and application accessibility based on environments.
  
  ** Secure Shell Protocol (SSH) keys can be pre-configured and installed on the server to allow secure sessions with the all the server instances.
  
  ** Access to the server instances is limited based on the environment.  Dev can be configured to only allow developer access.  Stg can be configured to only allow corporate user access.  Prd can be configured to allow general Internet access.

* Flexible: The code can be customized for individual environments, based on your application needs, for example.  the AWS Machine Images (ami) for each region can be preconfigure, without the need to have project specify them for every region. Additional configuration parameters are already in the code to allow for easy customization.
  
* Auditable: The code creates output and logging where possible.
  ** The public IP and DNS name for servers’ instances created are output in Terraform to allow easy access to the new instance

  ** Scripts on servers create a local trail of activity as well as log to the syslog or remote syslogger.

* Easy to use:  All code contains a banner with project, usage, pre-requisite and beware sections.  In addition, tags to identify the project, environment and other identifiable information are added where possible.

## Pre-requisites

To use this code base, AWS cli, Terraform and Ansible are required to be installed locally on the server.

   * AWS cli access configuration (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
  
   * Terraform by HashiCorp (https://www.terraform.io/)
  
   * Ansible (https://www.ansible.com/)

   * An OpenSSH key-pair must be available to upload to the new environment

## How to use and maintain

* To create the example environment using Terraform, in the SDLC directory for the environment to deploy, for example, dev

  $ terraform init

  $ terraform fmt

  $ terraform validate

  $ terraform plan

  $ terraform apply
  
 Once the server instance is created, terraform will output the server’s name and IP.  You can retrieve this output at any time after creating the instances by running 
  
   $ terraform output
  
Once you have the new instance DNS name information, connect to each instance to ensure your connection and ssh keys work.

for example:  
  ssh ubuntu@ec2-54-92-22-20.compute-1.amazonaws.com 
  and accept the server ssh key into the ssh known-hosts
 
  or
  
  ssh -o StrictHostKeyChecking=accept-new ubuntu@ec2-54-92-22-20.compute-1.amazonaws.com    
  to automatically accept the ssh key

* To install applications and files on the new instances, using Ansible.

  **   add the server instances to the ansible host list at/etc/ansible/hosts.  The example ansible host files use application grouping to install software.  The new instances should be under the awsTest test host groups.

  ** go to the directory containing the Ansible playbook

     $ ansible-playbook playbook.yml

     Ansible will output a log of the tasks.  In the example playbook, Ansible copies an application and configuration files to all new instances, and runs the application to install some new software.

  The application also creates a blank cookie as a local audit trail for the activity, and logs the event to syslog.

  To check for the application results, ssh to the server instance.  Change directory to /opt/csg_security_agent and inspect the date time of the agent_install_date file.  This will be zero length file.
  
  Alternatively, look in /var/log/syslog for an entry "ansible agent installation SUCCESSFUL" entry.  Logging to a central remote syslog server allows for tracking of the ansible events and date for audit purposes. 

## Roadmap

Please email me for features and additions you would like to see.  

or

## Get Involved

* Submit a proposed code update through a pull request to the `devel` branch.
* Talk to us before making larger changes
  to avoid duplicate efforts. This not only helps everyone
  know what is going on, but it also helps save time and effort if we decide
  some changes are needed.

## Author

Terraform-with-ansible was created by [Bobby Wen] (https://github.com/bobby1) as a primer to Terraform and ansible.

## License

MIT License

https://github.com/bobby1/terraform-with-ansible/blob/main/LICENSE
