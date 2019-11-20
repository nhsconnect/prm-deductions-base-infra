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

module "transit-opentest" {
    source              = "./modules/transit-opentest/"
    region = "${var.region}"

    component_name              = "transit-opentest"
    cidr                        = "10.10.0.0/16"
    public_subnets              = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnets             = ["10.10.101.0/24", "10.10.102.0/24"]
    azs                         = ["eu-west-2a", "eu-west-2b"]
}
