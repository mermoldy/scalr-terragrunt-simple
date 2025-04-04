
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
variable "module_name" {
  description = "The name of the module"
  default = "test_module_name"
  type        = string
}

variable "resource_id" {
  description = "A unique identifier for the resource"
  type        = string
  default = "test_resource_id"
}

variable "dependency_info" {
  description = "Information from dependent modules"
  type        = map(string)
  nullable    = true
  default     = null
}

resource "null_resource" "random_sleep_example_shuf" {
  triggers = {
    force_recreation = timestamp()
  }
  provisioner "local-exec" {
    command = "sleep $(shuf -i 1-20 -n 1)"
  }
}

#resource "null_resource" "show_env" {
#  provisioner "local-exec" {
#    command = "env"
#  }
#}


resource "null_resource" "placeholder" {
  count = 3
  triggers = {
    module_name     = var.module_name
    resource_id     = var.resource_id
    dependency_data = jsonencode(var.dependency_info)
  }

  provisioner "local-exec" {
    command = "echo ${var.module_name} resource created with dependency info: ${jsonencode(var.dependency_info)}"
  }
}

resource "random_string" "example" {
  count = 2 
  length  = 16
  special = false
  upper   = true
  lower   = true
  numeric  = true
}

output "resource_output" {
  value = {
    module_name = var.module_name
    resource_id = var.resource_id
  }
}

output "module_name" {
  description = "The name of the module"
  value = random_string.example[0].result
}

output "resource_id" {
  description = "A unique identifier for the resource"
  value = random_string.example[0].result
}
