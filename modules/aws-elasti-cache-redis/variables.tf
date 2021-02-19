variable "node_type" {
  default     = "cache.t2.small"
  type        = string
  description = "redis cache node type(memory capacity of node)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Redis security group id"
}
