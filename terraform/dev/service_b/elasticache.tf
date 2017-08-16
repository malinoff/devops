resource "aws_elasticache_cluster" "service_b" {
  cluster_id = "${var.environment}-service_b"
  engine = "redis"
  engine_version = "2.8.24"
  node_type = "cache.t2.small"
  num_cache_nodes = 1
  parameter_group_name = "default.redis2.8"
  port = 6379
  subnet_group_name = "${aws_elasticache_subnet_group.service_b-redis.name}"
  security_group_ids = []

  tags = "${var.tags}"
}

resource "aws_elasticache_subnet_group" "service_b-redis" {
  name = "${env.environment}-service_b-redis"
  description = "${env.environment}-service_b-redis"
  subnet_ids = ["${aws_subnet.dev.id}"]

  tags = "${var.tags}"
}

resource "aws_security_group" "service_b-redis" {
  name = "${var.environment}-service_b-redis"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${var.security_group_id}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${var.security_group_id}"]
  }

  tags = "${var.tags}"
}
