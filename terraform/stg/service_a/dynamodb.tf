resource "aws_dynamodb_table" "table-a" {
  name = "${var.environment}-table-a"
  read_capacity = 3
  write_capacity = 3
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = "${var.tags}"
}

resource "aws_dynamodb_table" "table-b" {
  name = "${var.environment}-table-b"
  read_capacity = 3
  write_capacity = 2
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = "${var.tags}"
}
