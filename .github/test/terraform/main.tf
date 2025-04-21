terraform {
  required_version = ">= 1.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "time_static" "now" {}

resource "local_file" "hello_file" {
  content  = "Hello from Terraform at ${time_static.now.rfc3339} with pet name ${random_pet.name.id}"
  filename = "${path.module}/hello.txt"
}

output "file_path" {
  value = local_file.hello_file.filename
}

output "generated_name" {
  value = random_pet.name.id
}

