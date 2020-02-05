resource "aws_ecr_repository" "poc" {
    name = "prm/prm-migration-poc"
}

resource "aws_ecr_repository" "generic-component-repo" {
    name = "deductions/generic-component"
}