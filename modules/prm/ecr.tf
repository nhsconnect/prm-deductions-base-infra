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