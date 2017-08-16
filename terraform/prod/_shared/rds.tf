resource "aws_db_instance" "db" {
  identifier = "${var.environment}-db"

  engine = "postgres"
  engine_version = "9.6.1"
  port = 5432
  instance_class = "db.t2.medium"
  storage_type = "gp2"
  allocated_storage = 500

  username = "postgres"
  password = "password"

  publicly_accessible = false
  multi_az = false
  availability_zone = "us-west-2a"

  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name = "${aws_db_subnet_group.db.id}"
  parameter_group_name = "${aws_db_parameter_group.db.id}"

  backup_retention_period = 1
  backup_window = "08:00-08:30"
  maintenance_window = "sat:09:00-sat:09:30"
  final_snapshot_identifier = "${var.environment}-db-final"

  tags = "${merge(map("Component", "service_a,service_b,service_c"), var.tags)}"
}

resource "aws_db_subnet_group" "db" {
  name = "${var.environment}-db"
  subnet_ids = ["${aws_subnet.prod.id}"]

  tags = "${merge(map("Component", "service_a,service_b,service_c"), var.tags)}"
}

resource "aws_db_parameter_group" "db" {
  name = "${var.environment}-db"
  family = "postgres9.6"

  tags = "${merge(map("Component", "service_a,service_b,service_c"), var.tags)}"
}
