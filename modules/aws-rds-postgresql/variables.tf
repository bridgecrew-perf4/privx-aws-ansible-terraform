variable "allocated_storage" {
  default     = 20
  type        = number
  description = "Storage allocated to database instance"
}

variable "instance_type" {
  default     = "db.t2.medium"
  type        = string
  description = "Instance type for database instance"
}

variable "engine_version" {
  default     = "11.6"
  type        = string
  description = "Database engine version"
}

variable "database_name" {
  default     = "privx"
  type        = string
  description = "Name of database inside storage engine"
}

variable "database_username" {
  default     = "privx"
  type        = string
  description = "Name of user inside storage engine"
}

variable "database_password" {
  type        = string
  description = "Database password inside storage engine"
}

variable "security_group" {
  type        = list(string)
  description = "Database security group"
}
