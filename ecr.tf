# resource "aws_ecr_repository" "medusa_repo" {
#   name = "medusa"
# }

resource "aws_ecr_repository" "medusa" {
  name         = "medusa"
  force_delete = true
  # other configurations...
}
