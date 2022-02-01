variable "region" {
  type        = string
  description = "AWS regin"
}

variable "instance_typeprivx" {
  default     = "t2.medium"
  type        = string
  description = "EC2 instance type for Privx"
}

variable "additional_privx_instance_count" {
  type        = number
  default     = 0
  description = "Number of additional PrivX EC2 Instances for HA"
}

variable "key_name" {
  type        = string
  description = "AWS key pair name for SSH password less authentication"
}

variable "os_username" {
  default     = "centos"
  type        = string
  description = "OS username on EC2 instnaces for which private key specified"
}

variable "privx_superuser" {
  default     = "admin"
  type        = string
  description = "Privx superuser name"
}

variable "email_domain" {
  default     = "example.com"
  type        = string
  description = "email domain to setup email id for privx superuser"
}

variable "allocated_storage" {
  default     = 20
  type        = number
  description = "Storage allocated to database instance"
}

variable "instance_typedb" {
  default     = "db.t2.medium"
  type        = string
  description = "Instance type for database instance"
}

variable "engine_version" {
  default     = "12.4"
  type        = string
  description = "Database engine version"
}

variable "database_name" {
  default     = "privx"
  type        = string
  description = "Name of database"
}

variable "database_username" {
  default     = "privx"
  type        = string
  description = "Name of master database user"
}

variable "dns-domain" {
  type        = string
  description = "Public Route53 domain with dot at end"
}

variable "public-fqdn" {
  type        = string
  description = "Public FQDN "
}

variable "webserver-port" {
  type    = number
  default = 443
}
