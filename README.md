# terraform-with-ansible
This code is a basic demonstration of ways to create Structured Design Life Cycle (SDLC) deployment cloud environments with minimum effort.  The code uses terraform to create an Amazon Web Services (AWS).  Then Ansible is used to push basic tools and configuration to the new server instances and install a security agent.

## Design Principles
* Reusable code: The same code base is used for all environment, implementation differences are set based on the environment or tier for the SDLC.
* SDLC from the start: Development (dev), Staging (stg) and Production (prd) folders are available to allow checkout of the code to implement a project using all basic tiers at the beginning of a project.
* Scalable:  the environment setting allows each environment to scale automatically.  Development environment use micro server instance (t2.micro) to service a small number of developers, staging environments uses medium server instances (t2.medium) to allow a large audience to test the application.  Production environments uses large server instances (t2.large) to be generally available to the Internet.
  ** Similarly, dev environments will create two server instances.  Stg environments will create four server instances.  And Prd environments will create six server instances automatically
  


