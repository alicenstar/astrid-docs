output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "rds_endpoint" {
  description = "PostgreSQL RDS endpoint (host:port)"
  value       = aws_db_instance.postgresql.endpoint
}

output "rds_database_name" {
  description = "PostgreSQL database name"
  value       = aws_db_instance.postgresql.db_name
}

output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "load_balancer_dns" {
  description = "Application load balancer DNS name"
  value       = aws_lb.app.dns_name
}
