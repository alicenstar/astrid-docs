provider "aws" {
  region = var.region
}

# --- EKS Cluster ---

resource "aws_eks_cluster" "main" {
  name     = "${var.app_name}-${var.environment}"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.app_name}-${var.environment}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.app_name}-workers"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = var.subnet_ids

  instance_types = [var.eks_node_instance_type]

  scaling_config {
    desired_size = var.eks_desired_capacity
    max_size     = var.eks_desired_capacity + 1
    min_size     = 1
  }

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "eks_node" {
  name = "${var.app_name}-${var.environment}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# --- PostgreSQL (RDS) ---

resource "aws_db_instance" "postgresql" {
  identifier     = "${var.app_name}-${var.environment}-pg"
  engine         = "postgres"
  engine_version = "16.4"
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = "gp3"

  db_name  = var.app_name
  username = var.app_name
  password = "CHANGE_ME"

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  skip_final_snapshot = true

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.app_name}-${var.environment}-db-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds" {
  name   = "${var.app_name}-${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

# --- Redis (ElastiCache) ---

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.app_name}-${var.environment}-redis"
  engine               = "redis"
  engine_version       = "7.0"
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids   = [aws_security_group.redis.id]

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.app_name}-${var.environment}-redis-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "redis" {
  name   = "${var.app_name}-${var.environment}-redis-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

# --- Load Balancer ---

resource "aws_lb" "app" {
  name               = "${var.app_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids

  tags = {
    Application = var.app_name
    Environment = var.environment
  }
}
