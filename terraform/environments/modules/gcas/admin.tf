resource "random_password" "admin_gcas" {
  length  = 16
  special = false
  keepers = {
    version = "1"
  }
}

resource "kubernetes_secret" "admin_gcas" {
  metadata {
    name      = "admin-gcas"
    namespace = var.environment_namespace
  }

  data = {
    ADMIN_USER     = "admin"
    ADMIN_PASSWORD = random_password.admin_gcas.result
  }
}
