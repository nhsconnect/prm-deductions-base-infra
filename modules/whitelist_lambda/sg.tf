
resource "aws_security_group" "whitelist-lambda" {
    name        = "whitelist-lambda"
    vpc_id      = local.vpc_id

    egress {
        description = "Allow All Outbound"
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "whitelist-lambda"
    }
}
