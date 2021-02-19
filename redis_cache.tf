module "redis_cache" {
  source             = "./modules/aws-elasti-cache-redis"
  node_type          = var.node_type
  security_group_ids = [aws_security_group.privx-redis.id]
}