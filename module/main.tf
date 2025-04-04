variable "region" {

}


terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.60.0, <= 5.89.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.22.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.1.2"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    consul = {
      source = "hashicorp/consul"
    }
    random = {
      source = "hashicorp/random"
    }
    helm = {
      source = "hashicorp/helm"
    }
    nomad = {
      source = "hashicorp/nomad"
    }
  }
}

variable "test" {}

provider "aws" {
  region = var.region
}

# resource "aws_s3_bucket" "test_bucket" {
#  bucket = var.bucket_name
#  acl    = "private"
# }


resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "sleep 1"  # replace 300 with the number of seconds you want to sleep
  }
  triggers = {
    always_run = timestamp()
  }
}

#output "bucket_name" {
#  value = aws_s3_bucket.test_bucket.bucket
#}


#output "bucket_arn" {
#  value = aws_s3_bucket.test_bucket.arn
#}
