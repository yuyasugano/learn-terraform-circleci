variable "name" {}
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

