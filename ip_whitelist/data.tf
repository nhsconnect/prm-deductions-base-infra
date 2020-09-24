data "aws_caller_identity" "current" {}

# The legacy whitelist, should have only offices in it
data "aws_ssm_parameter" "inbound_ips" {
    name = "/repo/dev/prm-deductions-base-infra/output/tf-inbound-ips"
}

data "aws_ssm_parameter" "agent_ips" {
    name = "/repo/prod/prm-deductions-base-infra/output/gocd-agent-ips"
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
  name = "/repo/prm-deductions-base-infra/user-input/whitelisted-ipv4-${var.users[count.index]}"
}

data "aws_ssm_parameter" "dev_vpc_id" {
  name = "/repo/dev/prm-deductions-base-infra/output/private-vpc-id"
}

data "aws_ssm_parameter" "test_vpc_id" {
  name = "/repo/test/prm-deductions-base-infra/output/private-vpc-id"
}

data "aws_ssm_parameter" "gocd_vpc_id" {
  name = "/repo/prod/prm-deductions-base-infra/output/gocd-vpc-id"
}
