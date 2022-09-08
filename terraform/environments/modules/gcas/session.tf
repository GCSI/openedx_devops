
resource "random_password" "gcas_secret_key" {
  length  = 24
  special = false
  keepers = {
    version = "1"
  }
}

resource "kubernetes_secret" "gcas_secret_key" {
  metadata {
    name      = "gcas-secret-key"
    namespace = var.environment_namespace
  }

  data = {
    GCAS_SECRET_KEY = random_password.gcas_secret_key.result
  }
}
