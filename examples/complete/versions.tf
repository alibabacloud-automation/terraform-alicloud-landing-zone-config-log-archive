terraform {
  required_version = ">= 1.3"
  required_providers {
    alicloud = {
      source  = "hashicorp/alicloud"
      version = ">= 1.229.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
  }
}
