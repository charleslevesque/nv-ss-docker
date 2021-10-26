terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.5"
    }
  }

  backend "kubernetes" {
    namespace        = "default"
    secret_suffix    = "state"
    load_config_file = true
  }
}

provider "kubernetes" {
  config_path    = var.k8s_config_path
  config_context = var.k8s_context_name
}
