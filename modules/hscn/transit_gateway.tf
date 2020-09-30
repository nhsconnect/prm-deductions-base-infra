resource "aws_ec2_transit_gateway" "hscn" {
  description = "HSCN Transit Gateway"

  tags = {
    CreatedBy = var.repo_name
  }
}
