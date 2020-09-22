resource "aws_ecr_repository" "poc" {
    name = "prm/prm-migration-poc"
}

resource "aws_ecr_repository" "generic-component-repo" {
    name = "deductions/generic-component"
}

resource "aws_ecr_repository" "administration-portal-repo" {
    name = "deductions/administration-portal"
} 

resource "aws_ecr_repository" "gp-to-repo-repo" {
    name = "deductions/gp-to-repo"
} 

resource "aws_ecr_repository" "gp2gp-adaptor-ecr-repo" {
    name = "deductions/gp2gp-adaptor"
}

resource "aws_ecr_repository" "ehr-repo-ecr-repo" {
    name = "deductions/ehr-repo"
}