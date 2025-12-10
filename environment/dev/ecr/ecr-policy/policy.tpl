{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire untagged images older than ${UNTAGGED_EXPIRE_DAYS} days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": "${UNTAGGED_EXPIRE_DAYS}"
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire images more than ${ALL_EXPIRE_COUNT} count",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": "${ALL_EXPIRE_COUNT}"
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
