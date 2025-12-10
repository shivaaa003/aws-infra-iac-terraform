resource "aws_ecr_repository" "ecr" {
  for_each             = local.workspace["ecr"]["names"]
  name                 = "${local.service_name_prefix}-${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = each.value["scan_on_push"]
  }

  tags = merge(local.common_tags, {
    "Name" = "${local.service_name_prefix}-${each.key}"
  })
}

data "template_file" "ecr_policy" {
  for_each = aws_ecr_repository.ecr
  template = file("${path.module}/ecr-policy/policy.tpl")
  vars = {
    all_expire_count      = local.workspace["ecr"]["names"][each.key]["all_image_expire_count"]
    untagged_expire_count = local.workspace["ecr"]["names"][each.key]["untagged_image_expire_count"]
  }
}

resource "aws_ecr_lifecycle_policy" "ecrpolicy" {
  for_each   = aws_ecr_repository.ecr
  repository = each.value.name
  policy     = data.template_file.ecr_policy[each.key].rendered
}