provider "aws" {
  profile   = "default"
  version   = "~> 2.27"
  region    = "${var.region}"
}

terraform{
      backend "s3" {
        bucket  = "prm-deductions-terraform-state"
        key     = "base/terraform.tfstate"
        region  = "eu-west-2"
        encrypt = true
    }
}

module "mhs" {
    source              = "./modules/mhs/"
    region = "${var.region}"
}

# module "hscn" {
#     source              = "./modules/hscn/"
#     region = "${var.region}"
# }

module "dns" {
    source              = "./modules/dns/"
}

module "prm" {
    source              = "./modules/prm/"
    region = "${var.region}"
}

module "whitelist" {
    source              = "./modules/whitelist_lambda/"
}
