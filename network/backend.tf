terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "juv-shun.tfstate"
    key    = "foundation/network/tfstate.tf"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
