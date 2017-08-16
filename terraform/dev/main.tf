# Not supposed to be overriden from the cli,
# it's here for copy-paste convenience
variable "environment" {
  type = "string"
  default = "dev"
}

terraform {
  backend "s3" {
    bucket = "project-terraform"
    key = "infrastructure/dev"
  }
}

resource "terraform_remote_state" "main" {
  backend = "s3"
  config {
    bucket = "project-terraform"
    key = "infrastructure/main"
  }
}

# XXX: certificate must be issued manually first
data "aws_acm_certificate" "main" {
  domain   = "*.dev.project.com"
  statuses = ["ISSUED"]
}

resource "aws_security_group" "elb" {
  name = "${var.environment}-elb"
  vpc_id = "${data.terraform_remote_state.main.vpc_id}"

  ingress {
    from_port = 0
    to_port = 80
    protocol = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 443
    protocol = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "infrastructure")
    )}"
}

resource "aws_security_group" "main" {
  name = "${var.environment}"
  vpc_id = "${data.terraform_remote_state.main.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.elb.id}"]
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "infrastructure")
    )}"
}

# Component-specific parts of the infrastructure
module "_shared" {
  source = "./_shared"
  security_group_id = "${aws_security_group.main.id}"
  environment = "${var.environment}"
  tags = "${merge(
    var.tags,
    map("Environment", var.environment)
  )}"
}

module "service_a" {
  source = "./service_a"
  environment = "${var.environment}"
  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "service_a")
  )}"
}

module "service_b" {
  source = "./service_b"
  vpc_id = "${aws_vpc.main.id}"
  security_group_id = "${aws_security_group.main.id}"
  environment = "${var.environment}"
  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "service_a")
  )}"
}

module "service_c" {
  source = "./search-updater"
  environment = "${var.environment}"
  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "service_a")
  )}"
}

module "service_d" {
  source = "./service_d"
  tags = "${merge(
    var.tags,
    map("Environment", var.environment,
        "Component", "service_a")
  )}"
}
