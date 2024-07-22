provider "aws" {
  region = var.region
  #   shared_credentials_files = var.shared_credentials_files
  profile = var.aws_profile
}