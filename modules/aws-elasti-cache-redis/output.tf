output "redis_address" {
  value       = aws_elasticache_cluster.default.cache_nodes.0.address
  description = "DNS name of redis endpoint"
}
