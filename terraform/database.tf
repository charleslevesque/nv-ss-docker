locals {
  database_selector_labels = {
    "app.kubernetes.io/instance"  = "database-1"
    "app.kubernetes.io/name"      = "database"
    "app.kubernetes.io/component" = "database"
  }
}

locals {
  database_labels = merge(local.database_selector_labels, local.common_labels)
}

resource "kubernetes_secret" "database-secret" {
  metadata {
    name      = "database-secret"
    namespace = kubernetes_namespace.nvssdocker.id
    labels    = local.common_labels
  }

  data = var.database_secrets
}

resource "kubernetes_service" "database-service" {
  count = var.database_enabled ? 1 : 0

  metadata {
    name      = "database-service"
    namespace = kubernetes_namespace.nvssdocker.id
    labels    = local.common_labels
  }

  spec {
    port {
      port        = 1433
      target_port = "mssql"
      name        = "mssql"
    }

    cluster_ip = "None"
    selector   = local.database_selector_labels
  }
}

resource "kubernetes_stateful_set" "database" {
  count = var.database_enabled ? 1 : 0

  metadata {
    name      = "nvssdocker-database"
    namespace = kubernetes_namespace.nvssdocker.id
    labels    = local.database_labels
  }

  spec {
    replicas     = var.database_replica_count
    service_name = kubernetes_service.database-service[count.index].id

    selector {
      match_labels = local.database_selector_labels
    }

    template {
      metadata {
        labels = local.database_selector_labels
      }

      spec {
        container {
          name              = "database"
          image             = "mcr.microsoft.com/mssql/server:2019-CU12-ubuntu-20.04"
          image_pull_policy = "Always"

          resources {
            limits   = { for k, v in var.database_resources.limits : k => v }
            requests = { for k, v in var.database_resources.requests : k => v }
          }

          port {
            name           = "mssql"
            container_port = 1433
            host_port      = var.database_host_port
          }

          env {
            name  = "ACCEPT_EULA"
            value = "Y"
          }

          env_from {
            secret_ref {
              name = kubernetes_secret.database-secret.id
            }
          }

          volume_mount {
            name       = "database-pvc"
            mount_path = "/var/opt/mssql"
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "database-pvc"
      }
      spec {
        access_modes       = ["ReadWriteMany"]
        storage_class_name = var.database_storage_class_name
        resources {
          requests = {
            storage = var.database_storage_request
          }
        }
      }
    }
  }
}
