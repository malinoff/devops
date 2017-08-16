resource "aws_dynamodb_table" "table_a" {
  name = "${var.environment}-table_a"
  read_capacity = 2
  write_capacity = 2
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = "${var.tags}"
}

resource "aws_dynamodb_table" "table_b" {
  name = "${var.environment}-table_b"
  read_capacity = 3
  write_capacity = 2
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = "${var.tags}"
}
