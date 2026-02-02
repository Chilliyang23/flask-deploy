terraform {
  backend "s3" {
    bucket         = "k8s-bootcamp-state"
    key            = "network/terraform.tfstate" # Path where this specific state is stored
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}