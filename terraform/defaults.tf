# Not supposed to be overriden from the cli,
# it's here for copy-paste convenience
variable "tags" {
  type = "map"
  default = {
    Project = "project"
    Terraformed = "yes"
  }
}
