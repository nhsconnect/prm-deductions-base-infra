provider "aws" {
  profile   = "default"
  version   = "~> 2.27"
  region    = var.region
}

terraform{
      backend "s3" {
        bucket  = "prm-deductions-terraform-state"
        key     = "ip_whitelist/terraform.tfstate"
        region  = "eu-west-2"
        encrypt = true
    }
}
