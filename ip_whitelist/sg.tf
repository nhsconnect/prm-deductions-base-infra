resource "aws_security_group" "dev_vpn_sg" {
  name        = "Dev VPN VM security group"
  description = "Security group for VPN VM in dev environment"
  vpc_id      = data.aws_ssm_parameter.dev_vpc_id.value

  # VPN from whitelisted IP
  ingress {
    from_port = var.vpn_port
    to_port   = var.vpn_port
    protocol  = "tcp"
    cidr_blocks = local.allowed_public_ips
  }

  ingress {
    from_port = var.vpn_port
    to_port   = var.vpn_port
    protocol  = "udp"
    cidr_blocks = local.allowed_public_ips
  }

  tags = {
    Name      = "VPN to dev env"
    CreatedBy = var.repo_name
    Environment = "dev"
  }
}

resource "aws_ssm_parameter" "dev_vpn_sg" {
  name = "/repo/dev/output/${var.repo_name}/vpn-sg"
  type = "String"
  value = aws_security_group.dev_vpn_sg.id

  tags = {
    CreatedBy = var.repo_name
    Environment = "dev"
  }
}

resource "aws_security_group" "test_vpn_sg" {
  name        = "Test VPN VM security group"
  description = "Security group for VPN VM in test environment"
  vpc_id      = data.aws_ssm_parameter.test_vpc_id.value

  # VPN from whitelisted IP
  ingress {
    from_port = var.vpn_port
    to_port   = var.vpn_port
    protocol  = "tcp"
    cidr_blocks = local.allowed_public_ips
  }

  ingress {
    from_port = var.vpn_port
    to_port   = var.vpn_port
    protocol  = "udp"
    cidr_blocks = local.allowed_public_ips
  }

  tags = {
    Name      = "VPN to test env"
    CreatedBy = var.repo_name
    Environment = "test"
  }
}

resource "aws_ssm_parameter" "test_vpn_sg" {
  name = "/repo/test/output/${var.repo_name}/vpn-sg"
  type = "String"
  value = aws_security_group.test_vpn_sg.id

  tags = {
    CreatedBy = var.repo_name
    Environment = "test"
  }
}

resource "aws_security_group" "gocd_sg" {
  name        = "GoCD public access"
  description = "Security group for GoCD public access"
  vpc_id      = data.aws_ssm_parameter.gocd_vpc_id.value

  # HTTPS from whitelisted IP
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = local.allowed_public_ips
  }

  tags = {
    Name      = "GoCD public access"
    CreatedBy = var.repo_name
    Environment = "prod"
  }
}

resource "aws_ssm_parameter" "gocd_sg" {
  name = "/repo/prod/output/${var.repo_name}/gocd-sg"
  type = "String"
  value = aws_security_group.gocd_sg.id

  tags = {
    CreatedBy = var.repo_name
    Environment = "prod"
  }
}
