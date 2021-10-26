locals {
  common_labels = {
    "app.kubernetes.io/version"    = var.app_version
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/created-by" = "terraform"
    "app.kubernetes.io/part-of"    = "nvssdocker"
  }
}
