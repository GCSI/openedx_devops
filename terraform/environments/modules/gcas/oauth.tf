resource "random_password" "gcas_oauth_clientid" {
  length  = 40
  special = false
  keepers = {
    version = "1"
  }
}

resource "random_password" "gcas_oauth_client_secret" {
  length  = 128
  special = false
  keepers = {
    version = "1"
  }
}


resource "random_password" "clientid_gcas" {
  length  = 40
  special = false
  keepers = {
    version = "1"
  }
}

resource "random_password" "clientsecret_gcas" {
  length  = 128
  special = false
  keepers = {
    version = "1"
  }
}

resource "kubernetes_secret" "openedx_api" {
  metadata {
    name      = "edx-api"
    namespace = var.environment_namespace
  }

  data = {
    CLIENT_ID     = random_password.gcas_oauth_clientid.result
    CLIENT_SECRET = random_password.gcas_oauth_client_secret.result
  }
}

resource "kubernetes_secret" "gcas" {
  metadata {
    name      = "gcas-oauth"
    namespace = var.environment_namespace
  }

  data = {
    CLIENT_ID     = random_password.clientid_gcas.result
    CLIENT_SECRET = random_password.clientsecret_gcas.result
  }
}
