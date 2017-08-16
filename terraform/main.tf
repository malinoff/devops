variable "region" {
  type = "string"
  default = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "project-terraform"
    key = "infrastructure/main"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = "${merge(
    var.tags,
    map("Component", "infrastructure",
        "Environment", "dev,stg,prod")
    )}"
}

resource "aws_subnet" "dev" {
  count = 3

  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet("10.0.0.0/16", 6, count.index)}"
  availability_zone = "${var.region}${element(list("a", "b", "c"), count.index)}"

  tags = "${merge(
    var.tags,
    map("Component", "infrastructure",
        "Environment", "dev")
    )}"
}

resource "aws_subnet" "stg" {
  count = 3

  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet("10.0.0.0/16", 6, count.index + 3)}"
  availability_zone = "${var.region}${element(list("a", "b", "c"), count.index)}"

  tags = "${merge(
    var.tags,
    map("Component", "infrastructure",
        "Environment", "stg")
    )}"
}

resource "aws_subnet" "prod" {
  count = 3

  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${cidrsubnet("10.0.0.0/16", 6, count.index + 6)}"
  availability_zone = "${var.region}${element(list("a", "b", "c"), count.index)}"

  tags = "${merge(
    var.tags,
    map("Component", "infrastructure",
        "Environment", "prod")
    )}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "dev_subnet_ids" {
  value = "${join(",", aws_subnet.dev.*.id)}"
}

output "stg_subnet_ids" {
  value = "${join(",", aws_subnet.stg.*.id)}"
}

output "prod_subnet_ids" {
  value = "${join(",", aws_subnet.prod.*.id)}"
}
