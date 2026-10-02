terraform {
  backend "s3" {
    bucket         = "caps-project-terraform-state"
    key            = "multi-env-web-app-infra/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "caps-project-terraform-locks"
    encrypt        = true
  }
}
