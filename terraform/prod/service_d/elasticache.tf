resource "aws_elasticache_cluster" "service_d" {
  cluster_id = "${var.environment}-service_d"
  engine = "redis"
  engine_version = "2.8.22"
  node_type = "cache.t2.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.redis2.8"
  port = 6379
  subnet_group_name = "${aws_elasticache_subnet_group.service_d-redis.name}"
  security_group_ids = []

  tags = "${var.tags}"
}

resource "aws_elasticache_subnet_group" "service_d-redis" {
  name = "${env.environment}-service_d-redis"
  description = "${env.environment}-service_d-redis"
  subnet_ids = ["${aws_subnet.prod.id}"]

  tags = "${var.tags}"
}
