terraform {
  backend "s3" {
    bucket         = "ttf-remote-backend-state-2025"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

