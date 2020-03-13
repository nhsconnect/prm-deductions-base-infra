variable "region" {
  default = "eu-west-2"
}

variable "vpn_port" {
  default = 443
}

#TODO: put allowed users here
variable "users" {
  default = [
    "tomzo",
    "rob"
  ]
}
