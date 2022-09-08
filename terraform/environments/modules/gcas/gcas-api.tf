resource "random_password" "gca_api_key" {
  length  = 40
  special = false
  keepers = {
    version = "1"
  }
}

resource "kubernetes_secret" "gca_api" {
  metadata {
    name      = "gcas-api"
    namespace = var.environment_namespace
  }

  data = {
    GCSI_BOOKING_SYSTEM_USER_API_KEY = random_password.gca_api_key.result
  }
}

