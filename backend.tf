terraform {
  backend "s3" {
    bucket         = "lab2bucket"
    key            = "state/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
