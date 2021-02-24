# Deploying PrivX to AWS with Terraform and Ansible 
This repo simplifies PrivX on-boarding experience with deployment automation using Infrastructure as a Code (terraform) and Ansible.


## Description:
This repository contain terraform code to spin 1 or more EC2 instances, setup AWS RDS postgreSQL database, AWS ElastiCache redis and AWS Application Load Balancer, AWS Certificate Manager for TLS/https, AWS Route53 for DNS and ansible for PrivX installation and configuration.

* Postgresql Database : AWS RDS PostgreSQL Database

* Redis Cache  : AWS ElasticCache Redis 

* PrivX Servers :  Centos7 AMI used for this instance. For High Availability setup value for variable "additional_privx_instance_count" can be set to 1 or more. 

* Application Load Balancer: AWS Application Load Balancer

* TLS/SSL Certificate: AWS Certificate Manager 

* DNS: AWS Route53

* PrivX installation and configuration: Ansible with dynamic inventory

## Pre-requisites : Install/Configure AWS and Terraform and update variables

1.  Install [Git](https://git-scm.com/downloads)
1.  Install [AWS CLI](https://aws.amazon.com/cli/) and use `aws configure` command to configure it.
1.  Install [Terraform](https://www.terraform.io/).
1.  Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-rhel-centos-or-fedora)
1.  Install boto3 for Ansible dynamic inventory `pip3 install boto3 --user`


#### Mandatory variables to be updated (create terraform.tfvars file and populate value for below listed variables)
```
# AWS region to be used
region = "eu-west-2"

# AWS key pair name for SSH password less authentication.
key_name = "default-linux-key"

# Public Route53 domain name with dot at end
dns-domain = "example.com."

# Public FQDN which will be used to access PrivX
public-fqdn = "privx.example.com"
```

**Note:** Add Private key data for AWS key(key_name) to ~/.ssh/id_rsa, ansible will use it for playbook execution.


#### Update AWS region in ansible/inventory_aws/tf_aws_ec2.yml file for ansible dynamic inventory  
```
regions:
  - eu-west-2
```

#### Optional variables: Default value for optional variable can be changed in variable.tf file (check variables.tf for all variables)
```
# EC2 instance type for Privx (default = t2.medium)
instance_typeprivx = "t2.medium"

# Number of additional PrivX EC2 Instances for HA (default = 0 so no HA)
additional_privx_instance_count = 0

# Instance type for database instance
instance_typedb = "db.t2.medium"

# Redis cache node type(memory capacity of node)
node_type = "cache.t2.small"
```

### Warning
* This repository expect users to obtain a Public Route53 domain name (configured as variable "dns-domain")

**Note:** RANDOM password for database and privx_superuser will be generated and included in output.


## Deployment
1. Run `terraform init`
1. Run `terraform plan` 
1. If plan looks good, run `terraform apply`

In the final step, please obtain a [license code](https://info.ssh.com/privx-free-access-management-software) to activate your environment.
   
## Next Steps
 * [Getting Started with PrivX](https://privx.docs.ssh.com/docs)

 
