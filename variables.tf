variable "region" {
  type = string
  default = "eu-west-2"
}

variable "repo_name" {
  type = string
  default = "prm-deductions-base-infra"
}

variable "common_account_id" {}
variable "common_account_role" {}


variable "root_dns_zone_id_in_ci" {}