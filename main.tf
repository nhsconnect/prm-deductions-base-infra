provider "aws" {
  profile   = "default"
  version   = "~> 2.27"
  region    = var.region
}

terraform{
      backend "s3" {
        bucket  = "prm-deductions-terraform-state"
        key     = "base-infra/terraform.tfstate"
        region  = "eu-west-2"
        encrypt = true
    }
}

# module "hscn" {
#     source              = "./modules/hscn/"
#     region = var.region
# }

module "dns" {
    source              = "./modules/dns/"
}