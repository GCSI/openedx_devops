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
