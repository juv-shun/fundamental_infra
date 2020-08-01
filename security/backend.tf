terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "juv-shun.tfstate"
    key    = "foundation/security/tfstate.tf"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "juv-shun.tfstate"
    key    = "foundation/network/tfstate.tf"
    region = "ap-northeast-1"
  }
}
