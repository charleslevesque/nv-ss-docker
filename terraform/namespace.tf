resource "kubernetes_namespace" "nvssdocker" {
  metadata {
    name = "nvssdocker"
  }
}
