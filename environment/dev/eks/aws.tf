terraform {
  backend "s3" {
    bucket  = "dhk-heartbeat-bucket"
    key     = "heartbeat/eks/main.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}