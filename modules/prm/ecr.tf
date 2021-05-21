resource "aws_ecr_repository" "gp-to-repo-repo" {
    name = "deductions/gp-to-repo"
    tags = {
        CreatedBy = var.repo_name
    }
}

resource "aws_ecr_repository" "repo-to-gp-repo" {
    name = "deductions/repo-to-gp"
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
