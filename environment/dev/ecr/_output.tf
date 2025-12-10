output "ecr_repo_url" {
  value = tomap({ for k, bd in aws_ecr_repository.ecr : k => bd.repository_url })
}