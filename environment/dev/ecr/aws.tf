terraform {
  backend "s3" {
    bucket  = "dhk-heartbeat-bucket"
    key     = "heartbeat/ecr/main.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}