terraform {
  backend "s3" {
    bucket         = "ttf-remote-backend-state-4286"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
