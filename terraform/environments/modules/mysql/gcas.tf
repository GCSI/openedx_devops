#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com
#
# date: sep-2022
#
# usage: create an gcas mysql credentials and store in kubernetes secrets.
#------------------------------------------------------------------------------

resource "random_password" "mysql_gcas" {
  length           = 16
  special          = true
  override_special = "_%@"
  keepers = {
    version = "1"

  }
}

resource "kubernetes_secret" "gcas" {
  metadata {
    name      = "mysql-gcas"
    namespace = var.kubernetes_namespace
  }

  data = {
    GCAS_MYSQL_USERNAME = "gcas"
    GCAS_MYSQL_PASSWORD = random_password.mysql_gcas.result
    MYSQL_HOST          = data.kubernetes_secret.mysql_root.data.MYSQL_HOST
    MYSQL_PORT          = data.kubernetes_secret.mysql_root.data.MYSQL_PORT
  }
}
