resource "aws_ecr_repository" "poc" {
    name = "prm/prm-migration-poc"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "generic-component-repo" {
    name = "deductions/generic-component"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "administration-portal-repo" {
    name = "deductions/administration-portal"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "gp-to-repo-repo" {
    name = "deductions/gp-to-repo"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "gp2gp-adaptor-ecr-repo" {
    name = "deductions/gp2gp-adaptor"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "gp2gp-message-handler-ecr-repo" {
    name = "deductions/gp2gp-message-handler"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "ehr-repo-ecr-repo" {
    name = "deductions/ehr-repo"
    tags = {
        CreatedBy = var.repo_name
    }
}
