variable "app_version" {
  type = string
}

variable "k8s_config_path" {
  type    = string
  default = "~/.kube/config"
}

variable "k8s_context_name" {
  type = string
}

variable "database_enabled" {
  type    = bool
  default = true
}

variable "database_resources" {
  type = object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = "1"
      memory = "2Gi"
    }
    requests = {
      cpu    = "1"
      memory = "2Gi"
    }
  }
}

variable "database_storage_request" {
  type    = string
  default = "10Gi"
}

variable "database_storage_class_name" {
  type    = string
  default = "standard"
}

variable "database_replica_count" {
  type    = number
  default = 1
}

variable "database_host_port" {
  type    = number
  default = 1433
}

variable "database_secrets" {
  type    = map(string)
  default = {}
}
