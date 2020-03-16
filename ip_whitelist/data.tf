data "aws_caller_identity" "current" {}

# The legacy whitelist, should have only offices in it
data "aws_ssm_parameter" "inbound_ips" {
    name = "/NHS/dev-${data.aws_caller_identity.current.account_id}/tf/inbound_ips"
}

data "aws_ssm_parameter" "agent_ips" {
    name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/gocd-prod/agent_ips"
}

locals {
  agent_cidrs = [
    for ip in split(",", data.aws_ssm_parameter.agent_ips.value):
      "${ip}/32"
  ]
  whitelist_ips = [
    for ip in data.aws_ssm_parameter.ip.*.value:
      "${ip}/32"
  ]
  # This local should be the only source of truth on what IPs are allowed to connect from the Internet
  allowed_public_ips = concat(
    local.whitelist_ips,
    split(",", data.aws_ssm_parameter.inbound_ips.value),
    local.agent_cidrs)
}

data "aws_ssm_parameter" "ip" {
  count = length(var.users)
  name = "/NHS/ip_whitelist/${var.users[count.index]}/ipv4"
}

data "aws_ssm_parameter" "dev_vpc_id" {
  name = "/nhs/dev/deductions_private_vpc_id"
}

data "aws_ssm_parameter" "test_vpc_id" {
  name = "/nhs/test/deductions_private_vpc_id"
}

data "aws_ssm_parameter" "gocd_vpc_id" {
  name = "/NHS/deductions-${data.aws_caller_identity.current.account_id}/gocd-prod/vpc_id"
}
