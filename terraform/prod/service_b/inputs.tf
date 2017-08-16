variable "vpc_id" {}

variable "environment" {}

variable "securiy_group_id" {}

variable "tags" {
  type = "map"
  default = {}
}
