resource "aws_ecr_repository" "mhs-inbound-repo" {
    name = "mhs-inbound"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "mhs-outbound-repo" {
    name = "mhs-outbound"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "scr-web-service-repo" {
    name = "mhs-scr-web-service"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "mhs-route-repo" {
    name = "mhs-route"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "mhs-unbound-dns" {
    name = "mhs-unbound-dns"
    tags = {
        CreatedBy = var.repo_name
    }
}
